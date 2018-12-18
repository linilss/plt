-- | Interpreter for lambda-calculus with if, +, -, <.
--
--   Strategy can be either call-by-value or call-by-name.

module Interpreter where

import Control.Applicative
import Control.Monad.Reader

import Data.Functor
import Data.Map (Map)
import qualified Data.Map as Map

import FUN.Abs
import FUN.ErrM
import FUN.Print

-- | Evaluation strategy.

data Strategy
  = CallByName
  | CallByValue

-- | Entry point: Program computes a number.

interpret :: Strategy -> Program -> Err Integer
interpret strategy (Prog defs (DMain mainExp)) = do

  -- Create initial environment
  let defToSigEntry (DDef f xs e) = (f, foldr EAbs e xs)
  let sig = Map.fromList (map defToSigEntry defs)
  let cxt = Cxt
        { cxtStrategy = strategy
        , cxtSig      = sig
        , cxtEnv      = Map.empty
        }

  -- Run the interpreter.
  -- v <- eval mainExp `runReaderT` cxt  -- with Reader monad
  v <- eval cxt mainExp  -- without Reader monad

  -- Inspect the result.
  case v of
    VInt i  -> return i
    VClos{} -> Bad "main should return an integer"

-- * Data structures for the interpreter.

-- | Context.

data Cxt = Cxt
  { cxtStrategy :: Strategy  -- ^ Evaluation strategy (fixed).
  , cxtSig      :: Sig       -- ^ Binds func idents to expression.
  , cxtEnv      :: Env       -- ^ Binds local variables to values.
  }

-- | Signature.

type Sig = Map Ident Exp  -- ^ 'Exp' is closed.

-- | Environment.

data Entry
  = Clos Exp Env  -- ^ For call-by-name.
  | Val  Value    -- ^ For call-by-value.

-- | Values.

data Value
  = VInt  Integer
  | VClos Ident Exp Env

type Env = Map Ident Entry

-- | Evaluation monad.

type Eval = ReaderT Cxt Err

-- * Interpreter.

todo = error "not yet implemented, TODO!"
todo2 = error "Well shit"
todo3 = error "This is good"

-- -- | Evaluation (with reader monad).
-- eval :: Exp -> Eval Value
-- eval e = todo

-- | Evaluation.
eval :: Cxt -> Exp -> Err Value
eval cxt e = case e of

  EInt i    -> return $ VInt i

  EVar x    -> do
    case Map.lookup x (cxtEnv cxt) of
      Just v -> evalEntry cxt v
      Nothing -> do
        case Map.lookup x (cxtSig cxt) of
          Just f -> return $ VClos x f (cxtEnv cxt)
          Nothing -> error $ "variable not declared: " ++ show x
    --lookFor cxt x

  EAbs x e  -> return $ VClos x e (cxtEnv cxt)

  EApp f e  -> do
    ff <- eval cxt f
    case ff of
      VInt i          -> error $ "Eapp for ints..." ++ show f
      VClos x f env   -> do
        ve <- eval cxt e
        VClos x' f' env <- eval cxt f
        let cxt' = cxt { cxtEnv = Map.insert x' (Val ve) (cxtEnv cxt) }
            cxt2 = newVar cxt x' ve
        eval  cxt2 f'

  EAdd e e' -> do
    VInt i1 <- eval cxt e
    VInt i2 <- eval cxt e'
    eval cxt (EInt (i1+i2))

  ESub e e' -> do
    VInt i1 <- eval cxt e
    VInt i2 <- eval cxt e'
    eval cxt (EInt (i1-i2))

  ELt  e e' -> do
    VInt i1 <- eval cxt e
    VInt i2 <- eval cxt e'
    case i1<i2 of
      True -> eval cxt (EInt 1)
      False -> eval cxt (EInt 0)

  EIf c t e -> do
    VInt b <- eval cxt c
    case b of
      1 -> eval cxt t
      0 -> eval cxt e


  where

-- | Evaluation of an environment entry.

evalEntry :: Cxt -> Entry -> Err Value
evalEntry cxt (Val v)      = return v
evalEntry cxt (Clos e env) = eval (cxt { cxtEnv = env }) e

lookupVar :: Cxt -> Ident -> Err Value
lookupVar cxt id = do
  case Map.lookup id (cxtEnv cxt) of
      (Just v) -> evalEntry cxt v
      Nothing  -> error $ "variable not declared in scope " ++ show id

lookupFun :: Cxt -> Ident -> Err Value
lookupFun cxt id = do
  case Map.lookup id (cxtSig cxt) of
    Just v  -> todo3
    Nothing -> todo2

newVar :: Cxt -> Ident -> Value -> Cxt
newVar cxt id val = do
  case Map.lookup id (cxtEnv cxt) of
    Just v -> error $ "Variable already exists"
    Nothing  -> Cxt
              { cxtStrategy = (cxtStrategy cxt)
              , cxtSig      = (cxtSig cxt)
              , cxtEnv      = Map.insert id (Val val) (cxtEnv cxt)
              }