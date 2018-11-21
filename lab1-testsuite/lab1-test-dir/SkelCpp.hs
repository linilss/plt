module SkelCpp where

-- Haskell module generated by the BNF converter

import AbsCpp
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transId :: Id -> Result
transId x = case x of
  Id string -> failure x
transProgram :: Program -> Result
transProgram x = case x of
  PDefs defs -> failure x
transDef :: Def -> Result
transDef x = case x of
  DFun type_ id args stms -> failure x
  DFunBody type_ id args -> failure x
  DUsing ids -> failure x
  DInit type_ vars -> failure x
  DTD type_ id -> failure x
transArg :: Arg -> Result
transArg x = case x of
  ADecl type_ var -> failure x
  ADeclInit type_ -> failure x
transStm :: Stm -> Result
transStm x = case x of
  SExp exp -> failure x
  SInit type_ vars -> failure x
  SReturn exp -> failure x
  SWhile exp stm -> failure x
  SBlock stms -> failure x
  SIf exp stm -> failure x
  SIfElse exp stm1 stm2 -> failure x
  SFor type_ vars exp1 exp2 stm -> failure x
  SDoWhile stm exp -> failure x
  STD type_ id -> failure x
transVar :: Var -> Result
transVar x = case x of
  VarDecl id -> failure x
  VarInit id exp -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EInt integer -> failure x
  EDouble double -> failure x
  EString strings -> failure x
  ETrue -> failure x
  EFalse -> failure x
  EChar char -> failure x
  EQCon ids -> failure x
  ECall exp exps -> failure x
  EStrDot exp1 exp2 -> failure x
  EStrArr exp1 exp2 -> failure x
  EIdx exp1 exp2 -> failure x
  EPIncr exp -> failure x
  EPDecr exp -> failure x
  EIncr exp -> failure x
  EDecr exp -> failure x
  ENeg exp -> failure x
  EMul exp -> failure x
  ETimes exp1 exp2 -> failure x
  EDiv exp1 exp2 -> failure x
  EMod exp1 exp2 -> failure x
  EPlus exp1 exp2 -> failure x
  EMinus exp1 exp2 -> failure x
  ERS exp1 exp2 -> failure x
  ELS exp1 exp2 -> failure x
  ELt exp1 exp2 -> failure x
  EGt exp1 exp2 -> failure x
  ELtEq exp1 exp2 -> failure x
  EGtWq exp1 exp2 -> failure x
  EEq exp1 exp2 -> failure x
  ENEq exp1 exp2 -> failure x
  EAnd exp1 exp2 -> failure x
  EOr exp1 exp2 -> failure x
  EAss exp1 exp2 -> failure x
  EAssAdd exp1 exp2 -> failure x
  EAssSub exp1 exp2 -> failure x
  ECond exp1 exp2 exp3 -> failure x
  EThrow exp -> failure x
transPType :: PType -> Result
transPType x = case x of
  Tbool -> failure x
  Tdouble -> failure x
  Tint -> failure x
  Tvoid -> failure x
  TChar -> failure x
  TQCon ids -> failure x
transRType :: RType -> Result
transRType x = case x of
  TPType ptype -> failure x
  TRef rtype -> failure x
transType :: Type -> Result
transType x = case x of
  TRType rtype -> failure x
  TConst rtype -> failure x

