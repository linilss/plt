module TypeChecker where

import Control.Monad

import Data.Map (Map)
import qualified Data.Map as Map

import CPP.Abs
import CPP.Print
import CPP.ErrM

data TypeData = FunT {returnType :: Type, argTypes :: [Type]}
              | VarT Type
type Env = (Sig, [Context])         -- functions and context stack
type Sig = Map Id ([Type], Type)    -- functions type signature
type Context = Map Id Type          -- variables with their types

typecheck :: Program -> Err ()
typecheck (PDefs defs) = do
  let builtIns = map (\(i, r, a) -> (Id i, FunT r a))
              [("printInt", Type_void, [Type_int])
              , ("printDouble", Type_void, [Type_double])
              , ("readInt", Type_int, [])
              , ("readDouble", Type_double, [])]
  return ()

lookupVar :: Env -> Id -> Err Type
lookupVar env id = do 
  fail $ "nope"

lookupFun :: Env -> Id -> Err ([Type], Type)
lookupFun env id = fail $ "nope"

updateVar :: Env -> Id -> Type -> Err Env
updateVar env id t = fail $ "nope"

updateFun :: Env -> Id -> ([Type], Type) -> Err Env
updateFun env id (ts, t) = fail $ "nope"

newBlock :: Env -> Env 
newBlock env = let
  empty_signature = Map.empty
  empty_context   = Map.empty
  in (empty_signature, [empty_context])

emptyEnv :: Env
emptyEnv = let
  empty_signature = Map.empty
  empty_context   = Map.empty
  in (empty_signature, [empty_context])

inferExp :: Env -> Exp -> Err Type
inferExp env x = case x of
  ETrue      -> return Type_bool
  EInt n     -> return Type_int
  EId id     -> lookupVar env id

inferBin :: [Type] -> Env -> Exp -> Exp -> Err ()
inferBin types env exp1 exp2 = do
  typ <- inferExp env exp1
  if elem typ types 
    then
      checkExp env typ exp2
    else
      fail $ "type of expression " ++ printTree exp1 

checkExp :: Env -> Type -> Exp -> Err ()
checkExp env typ exp = do
  typ2 <- inferExp env exp
  if (typ2 == typ) then do
    return ()
  else
    fail $  "type of " ++ printTree exp ++
            "expected " ++ printTree typ ++
            "but found " ++ printTree typ2

checkStm :: Env -> Type -> Stm -> Err Env
checkStm env val x = case x of
  SExp exp  -> do
    inferExp env exp
    return env
  SWhile exp stm  -> do
    checkExp env Type_bool exp
    checkStm env val stm
  
checkStms :: Env -> Type -> [Stm] -> Err Env
checkStms env typ stms = case stms of 
  [] -> return env
  x : rest -> do
    env1 <- checkStm env typ x 
    checkStms env1 typ rest      

printProg :: Program -> IO ()
printProg p = do
  let s = printTree p 
  putStrLn s
  return ()