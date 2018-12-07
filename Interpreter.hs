{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleInstances, TypeSynonymInstances #-}

module Interpreter where

import Control.Applicative
import Control.Monad
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State

import Data.List (elemIndex)
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
  let sigEntry (DFun _ f args ss) = (f, FunDef (map (\ (ADecl _ x) -> x) args) (checkTilReturn ss))
  let sig = Map.fromList $ map sigEntry defs
  -- Find the entry point ("main" function).
  let ss = maybe (error "no main") funBody $ Map.lookup (Id "main") sig
  -- Run the statements in the initial environment.
  () <$ runExceptT (evalStateT (runReaderT (evalStms $ ss) sig) emptyEnv)

-- | Execute statements from left to right.

evalStms :: [Stm] -> Eval Val
evalStms []  =  do
  return VVoid
evalStms  (s:ss) = do
  v <- evalStm s
  case v of
    VVoid -> evalStms ss
    _     -> return v

-- | Execute a single statement.

evalStm :: Stm -> Eval Val
evalStm s0 = case s0 of

  SReturn e -> do
    val <- evalExp e
    return val
  SDecls t ids -> do
    addDecls ids
    return VVoid
  SInit t x e -> do
    v <- evalExp e
    newVar x v
    return VVoid
  SExp e -> do
    evalExp e
    return VVoid
  SWhile e s -> do
    enterNewBlock
    v <- evalExp e
    case v of
      (VBool True) -> do
        enterNewBlock
        vv <- evalStms [s]
        exitBlock
        v <- evalStms [s0]
        exitBlock
        return vv
      (VBool False) -> do
        exitBlock
        return VVoid
  SBlock ss -> do
    enterNewBlock
    v <- evalStms ss
    --  liftIO $ putStrLn $ show v
    exitBlock
    return v
  SIfElse e s1 s2 -> do
    v <- evalExp e
    enterNewBlock
    case v of
      (VBool True)  -> do
              v <- evalStms [s1]
              exitBlock
              return v
      (VBool False) -> do
              v <- evalStms [s2]
              exitBlock
              return v
      _ -> error $ show v

  where
    enterNewBlock = do
      env <- get
      let newEnv = newBlock : env
      put newEnv

    exitBlock = do
      env <- get
      let oldEnv = drop 1 env
      put oldEnv

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
          let x = []
          let FunDef ids stms = lookupDef f sig

          if es /= [] then do
            vals <- evalExps es x
            enterNewBlock
            newVars ids vals

            val <- evalStms stms
            exitBlock
            return val

            else do
              enterNewBlock
              val <- evalStms stms
              exitBlock
              return val
      where
        evalExps (e:[]) vars = do
          v <- evalExp e
          let xs = vars ++ [v]
          return xs
        evalExps (e:es) vars  = do
          v <- evalExp e
          let xs = vars ++ [v]
          evalExps es xs

        newVars (id:[]) (v:[]) = do
          newVar id  v

        newVars (id:ids) (v:vals) = do
          newVar id v
          newVars ids vals

        enterNewBlock = do
          env <- get
          let newEnv = newBlock : env
          put newEnv

        exitBlock = do
          env <- get
          let oldEnv = drop 1 env
          put oldEnv

  EOr e1 e2 -> do
    v1 <- evalExp e1
    if (v1 == VBool True)
      then return v1
      else evalExp e2

  EAnd e1 e2 -> do
    v1 <- evalExp e1
    if (v1 == VBool False)
        then return v1
        else evalExp e2

  ELt e1 e2 -> cmp (<) e1 e2
  EGt e1 e2 -> cmp (>) e1 e2
  ELtEq e1 e2   -> cmp (<=) e1 e2
  EGtEq e1 e2   -> cmp (>=) e1 e2
  EEq   e1 e2   -> cmp (==) e1 e2
  ENEq  e1 e2   -> cmp (/=) e1 e2
  EPostIncr id   -> do
      val <- lookupVar id
      updateVar id (incr val)
      return $ case val of
        (VInt i) -> (VInt i)
        (VDouble d) -> (VDouble d)
  EPreIncr id    -> do
      val <- lookupVar id
      updateVar id (incr val)
      return $ case val of
        (VInt i) -> (VInt (i+1))
        (VDouble d) -> (VDouble (d+1))
  EPostDecr id -> do
      val <- lookupVar id
      updateVar id (decr val)
      return $ case val of
        (VInt i) -> (VInt (i))
        (VDouble d) -> (VDouble (d))
  EPreDecr id  -> do
      val <- lookupVar id
      updateVar id (decr val)
      return $ case val of
        (VInt i) -> (VInt (i-1))
        (VDouble d) -> (VDouble (d-1))
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

checkIfReturn :: [Stm] -> Stm
checkIfReturn (s:[]) = s
checkIfReturn (s:ss) = do
    case s of
        (SReturn e) -> s
        _           -> checkIfReturn ss

checkTilReturn :: [Stm] -> [Stm]
checkTilReturn ss = do
  let sss = reverse $ checkTilReturn' $ reverse ss
  case sss of
    [] -> ss
    es -> sss

checkTilReturn' :: [Stm] -> [Stm]
checkTilReturn' [] = []
checkTilReturn' (s:ss) = do
    case s of
        (SReturn e) -> (s:ss)
        _           -> checkTilReturn' ss
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

newVar :: Id -> Val -> Eval ()
newVar x v = modify $ \case
  b:bs -> case Map.lookup x b of
            Just val -> error $ "Variable already exists"
            Nothing -> Map.insert x v b : bs

--NOTE!! UpdateVar poss not correct, can be the reason why good17 fails.
updateVar :: Id -> Val -> Eval ()
updateVar i v = do
  modify $ \case
    bs -> the bs i
    where
      the (b:bs) i = do
        case Map.lookup i b of
            Just val -> (Map.adjust (\x -> v) i b):bs
            Nothing -> the' bs i (b:[])
      the' (b:bs) i cs = do
        case Map.lookup i b of
            Just val -> cs ++ (Map.adjust (\x -> v) i b):bs
            Nothing -> the' bs i (cs++[b])

-- bs -> [Map.adjust (\x -> v) i b | b <- bs]

lookupVar :: Id -> Eval Val
lookupVar x = do
  b <- get
  case catMaybes $ map (Map.lookup x) b of
    [] -> error $ show x ++ " variable not declared in scope"
    (t:ts) -> return t

lookupDef :: Id -> Sig -> FunDef
lookupDef id sig = do
  case Map.lookup id sig of
    Nothing -> error $ "undefined function " ++ printTree id
    Just d -> d

incr :: Val -> Val
incr (VInt i) = (VInt (i+1))
incr (VDouble d) = (VDouble (d+1))

decr :: Val -> Val
decr (VInt i) = (VInt (i-1))
decr (VDouble d) = (VDouble (d-1))