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
  v <- eval mainExp `runReaderT` cxt  -- with Reader monad
  --v <- eval cxt mainExp  -- without Reader monad

  -- Inspect the result.
  case v of
    VInt i  -> return i
    VClos{} -> Bad "main should return an integer"

-- * Data structures for the interpreter.

-- | Values.

data Value
  = VInt  Integer
  | VClos Ident Exp Env

-- | Context.

data Cxt = Cxt
  { cxtStrategy :: Strategy  -- ^ Evaluation strategy (fixed).
  , cxtSig      :: Sig       -- ^ Binds function identifiers to expression.
  , cxtEnv      :: Env       -- ^ Binds local variables to values.
  }

-- | Signature.

type Sig = Map Ident Exp  -- ^ 'Exp' is closed.

-- | Environment.

data Entry
  = Clos Exp Env  -- ^ For call-by-name.
  | Val  Value    -- ^ For call-by-value.

type Env = Map Ident Entry

-- | Evaluation monad.

type Eval = ReaderT Cxt Err

-- * Interpreter.

todo = error "not yet implemented, TODO!"
todo2 = error "well shit..."
todo3 = error "THIS IS GOOD!!!"

-- -- | Evaluation (with reader monad).
-- eval :: Exp -> Eval Value
-- eval e = todo

-- | Evaluation.
eval :: Exp -> Eval Value
eval e = case e of

  EInt i    -> return $ VInt i

  EVar x    -> do
    env <- asks cxtEnv
    str <- asks cxtStrategy
    case Map.lookup x env of
      Just v -> do
        case str of
          CallByValue -> evalEntry v
          CallByName -> do
            case v of
              Val (VInt n) -> evalEntry v
              Val (VClos x e env) -> do
                local (\cxt -> cxt { cxtEnv = env } ) $ eval e
      Nothing -> do
        sig <- asks cxtSig
        case Map.lookup x sig of
          Just e -> local (\ cxt -> cxt { cxtEnv = Map.empty}) (eval e)
          --local (\cxt -> cxt { e Map.empty } ) eval e
          --local (\ cxt -> cxt { cxtEnv = Map.empty}) (eval e)
          Nothing -> error $ show x ++ " not bound"

  EAbs x e  -> do
    env <- asks cxtEnv
    return $ VClos x e env


  EApp f a  -> do
    vf <- eval f
    case vf of
      VInt i -> todo2
      VClos x f' env -> do
        str <- asks cxtStrategy
        case str of
          CallByValue -> do
            va <- eval a
            local (\cxt -> cxt { cxtEnv = (Map.insert x (Val va) env) } ) $ eval f'
          CallByName -> do
            v <- eval $ EAbs x a
            local (\cxt -> cxt { cxtEnv = (Map.insert x (Val v) env) } ) $ eval f'

  EAdd e e' -> do
    e1  <- eval e
    e2  <- eval e'
    case (e1, e2) of
      (VInt i, VInt i') -> return (VInt (i + i'))
      _                 -> error $ "Not ints " ++ show e ++ " , " ++ show e'

  ESub e e' -> do
    e1  <- eval e
    e2  <- eval e'
    case (e1, e2) of
      (VInt i, VInt i') -> return (VInt (i - i'))
      _                 -> error $ "Not ints " ++ show e ++ " , " ++ show e'

  ELt  e e' -> do
    e1  <- eval e
    e2  <- eval e'
    case (e1, e2) of
      (VInt i, VInt i') -> do
        case i<i' of
          True -> return (VInt 1)
          False -> return (VInt 0)
      _                 -> error $ "Not ints " ++ show e ++ " , " ++ show e'

  EIf c t e -> do
    b <- eval c
    case b of
      VInt 1 -> eval t
      VInt 0 -> eval e

-- | Evaluation of an environment entry.

evalEntry :: Entry -> Eval Value
evalEntry (Val v)      = return v
evalEntry (Clos e env) = eval e
