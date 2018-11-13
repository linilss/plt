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
  DUsing qid -> failure x
  DFun type_ id args stms -> failure x
transArg :: Arg -> Result
transArg x = case x of
  ADecl type_ id -> failure x
transStm :: Stm -> Result
transStm x = case x of
  SExp exp -> failure x
  STypedef stm -> failure x
  SDecl type_ id -> failure x
  SDecls type_ id ids -> failure x
  SInit type_ id exp -> failure x
  SReturn exp -> failure x
  SWhile exp stm -> failure x
  SBlock stms -> failure x
  SIf exp stm -> failure x
  SIfElse exp stm1 stm2 -> failure x
  SUsing exp -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EInt integer -> failure x
  EString string -> failure x
  EStrings string exp -> failure x
  EDouble double -> failure x
  ETrue -> failure x
  EFalse -> failure x
  EQId qid -> failure x
  EStrProj id exp -> failure x
  ECall id exps -> failure x
  EPIncr exp -> failure x
  EPDecr exp -> failure x
  EIndex id exp -> failure x
  EIncr exp -> failure x
  EDecr exp -> failure x
  ENeg exp -> failure x
  EMul exp1 exp2 -> failure x
  EDiv exp1 exp2 -> failure x
  EMod exp1 exp2 -> failure x
  EAdd exp1 exp2 -> failure x
  ESub exp1 exp2 -> failure x
  ERS exp1 exp2 -> failure x
  ELS exp1 exp2 -> failure x
  ELt exp1 exp2 -> failure x
  EGt exp1 exp2 -> failure x
  ELEq exp1 exp2 -> failure x
  EGEq exp1 exp2 -> failure x
  EEq exp1 exp2 -> failure x
  ENEq exp1 exp2 -> failure x
  EAnd exp1 exp2 -> failure x
  EOr exp1 exp2 -> failure x
  EAss exp1 exp2 -> failure x
  ECond exp1 exp2 exp3 -> failure x
transQId :: QId -> Result
transQId x = case x of
  QIdent id -> failure x
  QIdElems qidelems -> failure x
transQIdElem :: QIdElem -> Result
transQIdElem x = case x of
  QIdElemId id -> failure x
transType :: Type -> Result
transType x = case x of
  Tbool -> failure x
  Tdouble -> failure x
  Tint -> failure x
  Tvoid -> failure x
  TQConst qid -> failure x

