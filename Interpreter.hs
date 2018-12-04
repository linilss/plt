{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleInstances, TypeSynonymInstances #-}

module Interpreter where

import Control.Applicative
import Control.Monad
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State

import Data.Functor
import Data.Maybe
import Data.Typeable
import Data.Map (Map)
import qualified Data.Map as Map

import CPP.Abs
import CPP.Print (printTree)


-- | The monad for the interpreter.
--
--   We use 'Reader' for the signature 'Sig',
--   'State' for the environment 'Env',
--   and 'Except' for returning from a function with 'Val'.

type Eval = ReaderT Sig (StateT Env (ExceptT Val IO))

-- | Function signature maps function identifiers to argument lists and statement list.

type Sig = Map Id FunDef
data FunDef = FunDef { funParams :: [Id], funBody :: [Stm] }

-- | Environment is a stack of blocks, mapping variable identifiers to values.

type Env = [Block]
type Block = Map Id Val

-- | Tagged values.

data Val
  = VBool   Bool
  | VInt    Integer
  | VDouble Double
  | VVoid           -- ^ Also used for uninitialized variable.
  deriving(Show,Eq,Ord)
-- | Entry point.

interpret :: Program -> IO ()
interpret (PDefs defs) = do
  -- Prepare the signature.
  let sigEntry (DFun _ f args ss) = (f, FunDef (map (\ (ADecl _ x) -> x) args) ss)
  let sig = Map.fromList $ map sigEntry defs
  -- Find the entry point ("main" function).
  let ss = maybe (error "no main") funBody $ Map.lookup (Id "main") sig
  -- Run the statements in the initial environment.
  () <$ runExceptT (evalStateT (runReaderT (evalStms ss) sig) emptyEnv)

-- | Execute statements from left to right.

evalStms :: [Stm] -> Eval ()  
evalStms = mapM_ evalStm

-- | Execute a single statement.

evalStm :: Stm -> Eval ()
evalStm s0 = case s0 of

  SDecls t ids -> do addDecls ids
  SReturn e ->  do
    v1 <- evalExp e
    return()
  SInit t x e -> do
    v <- evalExp e
    newVar x v
  SExp e -> do
    evalExp e
    return ()
  SWhile e s -> do
    v <- evalExp e
    case v of
      (VBool True) -> do
        enterNewBlock
        evalStm s
        evalStm s0
        exitBlock
      (VBool False) -> do
        return ()
  SBlock ss -> do
    enterNewBlock
    evalStms ss
    exitBlock
  SIfElse e s1 s2 -> do
    v <- evalExp e
    case v of
      (VBool True)  -> do
              enterNewBlock
              evalStm s1
              exitBlock
      (VBool False) -> do
              enterNewBlock
              evalStm s2
              exitBlock

  where
    enterNewBlock = do
      env <- get
      let newEnv = newBlock : env
      put newEnv

    exitBlock = do
      env <- get
      let oldEnv = drop 1 env
      put oldEnv

-- evalExps :: [Exp] -> Eval Val
-- evalExps = mapM_ evalExp

evalExp :: Exp -> Eval Val
evalExp = \case
  EInt i      -> return $ VInt i
  EId x       -> lookupVar x
  EDouble d   -> return $ VDouble d
  ETrue       -> return $ VBool True
  EFalse      -> return $ VBool False
  EApp f es   -> do
    case f of
      (Id "printInt") -> do
        VInt i <- evalExp $ head es
        liftIO $ putStrLn $ show i
        return VVoid
      (Id "printDouble") -> do
        VDouble i <- evalExp $ head es
        liftIO $ putStrLn $ show i
        return VVoid
      (Id "readInt") -> do
        i <- liftIO $ getLine
        return (VInt (read i))
      (Id "readDouble") -> do
        d <- liftIO $ getLine
        return $ VDouble $ read d
      (Id i) -> do
        sig <- ask
        let FunDef ids stms = lookupDef f sig
        let ess = es
        evalExps es
        evalStms stms
        return VVoid
      _ -> do error $ "EApp not implemented for other than basic funcktions"
          --sig <- ask
          --let a b =  map evalExp es
      where
        evalExps (e:[]) = do
          evalExp e
        evalExps (e:es) = do
          v <- evalExp e
          evalExps es

  EOr e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case v1 of
      (VBool True) -> return (VBool True)
      (VBool False) -> case v2 of
                        (VBool True)  -> return (VBool True)
                        (VBool False) -> return (VBool True)

  EAnd e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case v1 of
      (VBool True) -> case v2 of
                        (VBool True) -> return (VBool True)
                        _            -> return (VBool False)
      _            -> return (VBool False)

  ELt e1 e2 -> cmp (<) e1 e2
  EGt e1 e2 -> cmp (>) e1 e2
  ELtEq e1 e2   -> cmp (<=) e1 e2
  EGtEq e1 e2   -> cmp (>=) e1 e2
  EEq   e1 e2   -> cmp (==) e1 e2
  ENEq  e1 e2   -> cmp (/=) e1 e2
  EPostIncr i   -> do incOp i
  EPostDecr i   -> do decOp i
  EPreIncr i    -> do incOp i
  EPreDecr i    -> do decOp i
  ETimes e1 e2  -> do
      (v1,v2) <- evalExps e1 e2
      case (v1,v2) of
        (VInt i1, VInt i2)        -> return (VInt (i1 * i2))
        (VDouble d1, VDouble d2)  -> return (VDouble (d1 * d2))

  EDiv e1 e2  -> do
      (v1,v2) <- evalExps e1 e2
      case (v1,v2) of
        (VInt i1, VInt i2)        -> return (VInt (div i1 i2))
        (VDouble d1, VDouble d2)  -> return (VDouble (d1 / d2))

  EPlus e1 e2  -> do
      (v1,v2) <- evalExps e1 e2
      case (v1,v2) of
        (VInt i1, VInt i2)        -> return (VInt (i1 + i2))
        (VDouble d1, VDouble d2)  -> return (VDouble (d1 + d2))

  EMinus e1 e2  -> do
      (v1,v2) <- evalExps e1 e2
      case (v1,v2) of
        (VInt i1, VInt i2)        -> return (VInt (i1 - i2))
        (VDouble d1, VDouble d2)  -> return (VDouble (d1 - d2))

  EAss i e -> do
      v <- evalExp e
      updateVar i v
      return v

  where
    evalExps e1 e2 = do
      v1 <- evalExp e1
      v2 <- evalExp e2
      return (v1,v2)

    cmp op e1 e2 = do
      v1 <- evalExp e1
      v2 <- evalExp e2
      return (VBool $ v1 `op` v2)

    incOp i = do
      val <- lookupVar i
      let val' = case val of
            VInt i -> VInt $ i+1
            VDouble d -> VDouble $ d+1
      updateVar i val'
      return val'

    decOp i = do
      val <- lookupVar i
      let val' = case val of
            VInt i -> VInt $ i-1
            VDouble d -> VDouble $ d-1
      updateVar i val'
      return val'

-- * Variable handling

addDecls  :: [Id] -> Eval ()
addDecls (id:[])  = newVar id VVoid
addDecls (id:ids) = do
    newVar id VVoid
    addDecls ids

-- | The initial environment has one empty block.

emptyEnv :: Env
emptyEnv = [Map.empty]

newBlock :: Block
newBlock = Map.empty
-- | Insert binding into top environment block.

--newBlock :: Env
--newBlock = do
--  cxt <- get
--  put [Map.empty]:cxt

newVar :: Id -> Val -> Eval ()
newVar x v = modify $ \case
  b:bs -> Map.insert x v b : bs

updateVar :: Id -> Val -> Eval ()
updateVar i v = do
  modify $ \case
    bs -> [Map.adjust (\x -> v) i b | b <- bs]

lookupVar :: Id -> Eval Val
lookupVar x = do
  b <- get
  case catMaybes $ map (Map.lookup x) b of
    [] -> error "variable not declared in scope"
    (t:ts) -> return t

