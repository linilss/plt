{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}

-- | Type checker for C-- programs.

module TypeChecker where

import Control.Monad
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State

import Data.Functor
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set

import CPP.Abs
import CPP.Print (printTree)
import CPP.ErrM  (Err(Ok,Bad))

-- | The signature maps function identifiers to the list of their parameters and the return type.
type Sig     = Map Id FunType
data FunType = FunType { funRet :: Type, funPars :: [Type] }

-- | The state consists of the local context and the return type of the function.
data St = St
  { stCxt :: Cxt   -- ^ Variable bindings.
  , stRet :: Type  -- ^ Return type.
  }

-- | The local context is a stack of typing environments.
type Cxt   = [Block]
type Block = Map Id Type

-- | Type errors are just strings.
type TypeError = String

-- | The type checking monad
type Check = ReaderT Sig (StateT St (Except TypeError))

-- | Builtin-functions
builtin :: [(Id, FunType)]
builtin =
  [ (Id "readInt"    , FunType Type_int    [])
  , (Id "readDouble" , FunType Type_double [])
  , (Id "printInt"   , FunType Type_void [Type_int])
  , (Id "printDouble", FunType Type_void [Type_double])
  ]

-- | Entry point of type checker.
typecheck :: Program -> Err ()
typecheck prg@(PDefs defs) = do
  -- Prepare signature.
  let sig = builtin ++ map mkF defs
      mkF (DFun t f args _ss) = (f, FunType t $ map (\ (ADecl t _) -> t) args)
  -- Check for duplicate function definitions.

  -- Prepare the initial state.
  let st = undefined -- St [] $ error "no return type set"
      dups = dupDefs sig []
  -- Run the type checker.
  case runExcept (evalStateT (runReaderT (checkProgram prg dups) $ Map.fromList sig) st) of
    Left s   -> Bad s
    Right () -> return ()

dupDefs :: [(Id, FunType)] ->[Id] -> Bool
dupDefs ((i,f):[]) is = True
dupDefs ((i,f):sigs) [] = True && dupDefs sigs (i:[])
dupDefs ((i,f):sigs) is = dupDefs' i is && dupDefs sigs (i:is)

dupDefs' :: Id -> [Id] -> Bool
dupDefs' s ss = not (s `elem` ss)


-- | Check program: check definitions and main function.
checkProgram :: Program -> Bool -> Check ()
checkProgram (PDefs defs) dups = do
  unless (dups) $ throwError "dup"
  unless (length defs > 0) $ throwError "Empty program not allowed"
  mapM_ checkDef defs

-- | Check a single function definition.
checkDef :: Def -> Check ()
checkDef (DFun t f args ss) = do
  let mainArgs = case f of
        (Id "main") -> length args
        _ -> 0
  let mainStms = case f of 
        (Id "main") -> length ss
        _ -> 1
  unless (mainArgs == 0) $ throwError "No args allowed in main"
  unless (mainStms > 0) $ throwError "No function body in main"

  -- Set initial context and return type.
  put $ St [Map.empty] t
  -- Add function parameters to the context.
  mapM_ (\ (ADecl t x) -> newVar x t) args
  -- Check function body.
  mapM_ checkStm ss

-- | Check a single statement; mutates the context.
checkStm :: Stm -> Check ()
checkStm = \case
  SExp e -> do
    t' <- inferExp e
    return ()
  SInit t x e -> do
    checkExp e t
    newVar x t
  SDecls t is -> do
    case is of
      [] -> return ()
      (id:ids) -> do
        newVar id t
        checkStm (SDecls t ids)
  SReturn e -> do
    t <- inferExp e
    ret <- gets stRet
    if (t == ret)
      then return ()
      else throwError $ "Wrong return type"
  SWhile e s -> do
    cxt <- gets stCxt
    modifyCxt $ const (Map.empty:cxt)
    checkExp e Type_bool
    checkStm s
    modifyCxt $ const cxt
  SBlock ss -> do
    cxt <- gets stCxt
    modifyCxt $ const (Map.empty:cxt)
    mapM_ checkStm ss
    modifyCxt $ const cxt
  SIfElse e s1 s2 -> do
    checkExp e Type_bool
    cxt <- gets stCxt
    modifyCxt $ const (Map.empty:cxt)
    checkStm s1
    modifyCxt $ const cxt
    modifyCxt $ const (Map.empty:cxt)
    checkStm s2
    modifyCxt $ const cxt
  --s -> throwError $ "Bad statement"

-- | Infer the type of an expression.
inferExp :: Exp -> Check Type
inferExp = \case
  ETrue -> return Type_bool
  EFalse -> return Type_bool
  EInt i -> return Type_int
  EDouble d -> return Type_double
  EId i -> do
    lookupVar i
  EApp f es -> do
    sig <- ask
    case Map.lookup f sig of
      Nothing -> throwError $ "function " ++ printTree f ++ " unbound"
      Just (FunType t ts) -> do
        unless (length es == length ts) $
          throwError $ "wrong number of arguments"
        zipWithM_ checkExp es ts
        return t
  EPostIncr i -> do
    t <- lookupVar i
    numType t
  EPostDecr i -> do
    t <- lookupVar i
    numType t
  EPreIncr i  -> do
    t <- lookupVar i
    numType t
  EPreDecr i  -> do
    t <- lookupVar i
    numType t
  ETimes e1 e2  -> multTypes e1 e2
  EDiv e1 e2    -> multTypes e1 e2
  EPlus e1 e2   -> multTypes e1 e2
  EMinus e1 e2  -> multTypes e1 e2
  ELt e1 e2   -> compareSimilarNumType e1 e2
  EGt e1 e2   -> compareSimilarNumType e1 e2
  ELtEq e1 e2 -> compareSimilarNumType e1 e2
  EGtEq e1 e2 -> compareSimilarNumType e1 e2
  EEq e1 e2   -> compareSimilarType e1 e2
  ENEq e1 e2  -> compareSimilarType e1 e2
  EAnd e1 e2  -> compareSimilarType e1 e2
  EOr e1 e2   -> compareSimilarType e1 e2
  EAss i e    -> do 
    t1 <- lookupVar i
    t2 <- inferExp e
    if t1 == t2 then return t1 else throwError (show i ++ " not declared as " ++ show t2)
  where
    multTypes e1 e2 = do
      t1 <- inferExp e1
      if elem t1 [Type_int, Type_double]
        then do
          checkExp e2 t1
          return t1
        else throwError $ "wrong types in expression"
    numType t = do
      if elem t [Type_int, Type_double]
        then return t
        else throwError $ "wrong type in exp"
    compareSimilarType e1 e2 = do
      t1 <- inferExp e1
      t2 <- inferExp e2
      if (t1 == t2)
        then return Type_bool
        else throwError $ "different types in expression"
    compareSimilarNumType e1 e2 = do
      t1 <- inferExp e1
      t2 <- inferExp e2
      if (t1 == t2 && t1 `elem` [Type_int, Type_double] && t2 `elem` [Type_int, Type_double])
        then return Type_bool
        else throwError $ "different or wrong types in expression"

-- | Check an expression against a given type.
checkExp :: Exp -> Type -> Check ()
checkExp e t = do
  t' <- inferExp e
  unless (t == t') $ throwError $
    "expected type " ++ printTree t ++ ", but inferred type is " ++ printTree t'

-- * Variable handling

-- | Update the typing context.
modifyCxt :: (Cxt -> Cxt) -> Check ()
modifyCxt f = do
  modify $ \ (St bs t) -> St (f bs) t

-- | Add a new binding and make sure it is unique in the top context block.
newVar :: Id -> Type -> Check ()
newVar x t = do
  when (t == Type_void) $
    throwError $ "type void of variable " ++ printTree x ++ " is illegal"
  (b:bs) <- gets stCxt
  let (found, b') = Map.insertLookupWithKey (\ _ t _ -> t) x t b
  unless (isNothing found) $ throwError $ "duplicate variable binding " ++ printTree x
  modifyCxt $ const (b':bs)

--newFun :: Id -> Type -> Check ()
--newFun x t = do
--  (b:bs) <- gets stCxt
--  let (found, b') = Map.insertLookupWithKey (\ _ t _ -> t) x t b
--  unless (isNothing found) $ throwError $ "duplicate func binding " ++ printTree x
--  modifyCxt $ const (b':bs)

lookupVar :: Id -> Check Type
lookupVar i = do
  cxt <- gets stCxt
  case catMaybes $ map (Map.lookup i) cxt of
    [] -> throwError $ "Variable not declared in scope " ++ printTree i
    (t:ts) -> return t
