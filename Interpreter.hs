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
  SInit t x e -> do
    v <- evalExp e
    newVar x v
  SExp e -> do
    evalExp e
    return ()
  SWhile e s -> do
    evalExp e
    evalStm s
    return ()
  _ -> nyis

-- | Evalute an expression to a value.

evalExp :: Exp -> Eval Val
evalExp = \case
  EInt i -> return $ VInt i
  EId x      -> lookupVar x
  EDouble d  -> return $ VDouble d
  ETrue      -> return $ VBool True
  EFalse -> return $ VBool False
  EApp f es -> do
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
      _ -> nyid

 --EGt   e1 e2   -> comparision (>)  e1 e2
  --ELtEq e1 e2   -> comparision (<=) e1 e2
  --EGtEq e1 e2   -> comparision (>=) e1 e2
  --EEq   e1 e2   -> comparision (==) e1 e2
  --ENEq  e1 e2   -> comparision (/=) e1 e2

  ELt e1 e2 -> do 
    comp (<) e1 e2 

  e -> nyi
  where
    comp op x y = do
      if x `op` y
        then return (VBool True)
        else return (VBool False)

shit = error "omg"
nyi = error "NOT YET INTERPRETED"
nyid = error "NOT YET FUNCTION INTR"
nyis = error "NOT YET STM INTR"

  
-- * Variable handling

-- | The initial environment has one empty block.

emptyEnv :: Env
emptyEnv = [Map.empty]

-- | Insert binding into top environment block.

newVar :: Id -> Val -> Eval ()
newVar x v = modify $ \case
  b:bs -> Map.insert x v b : bs

lookupVar :: Id -> Eval Val
lookupVar x = do
  b <- get
  case catMaybes $ map (Map.lookup x) b of
    [] -> error "variable not declared in scope"
    (t:ts) -> return t
