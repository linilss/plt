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
  DFun type_ args stms -> failure x
transArg :: Arg -> Result
transArg x = case x of
  ADecl type_ id -> failure x
transStm :: Stm -> Result
transStm x = case x of
  SExp exp -> failure x
  SDecl type_ id -> failure x
  SInit type_ id exp -> failure x
  SReturn exp -> failure x
  SWhile exp stm -> failure x
  SBlock stms -> failure x
  SIfElse exp stm1 stm2 -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EInt integer -> failure x
  EDouble double -> failure x
  ETrue -> failure x
  EFalse -> failure x
  EId id -> failure x
  ECall id exps -> failure x
  EPIncr exp -> failure x
  EPDecr exp -> failure x
  EIncr exp -> failure x
  EDecr exp -> failure x
  ENeg exp -> failure x
  EMul exp1 exp2 -> failure x
  EDiv exp1 exp2 -> failure x
  EAdd exp1 exp2 -> failure x
  ESub exp1 exp2 -> failure x
  ELt exp1 exp2 -> failure x
  EGt exp1 exp2 -> failure x
  ELEq exp1 exp2 -> failure x
  EGEq exp1 exp2 -> failure x
  EEq exp1 exp2 -> failure x
  ENEq exp1 exp2 -> failure x
  EAnd exp1 exp2 -> failure x
  EOr exp1 exp2 -> failure x
  EAss exp1 exp2 -> failure x
transType :: Type -> Result
transType x = case x of
  Tbool -> failure x
  Tdouble -> failure x
  Tint -> failure x
  Tvoid -> failure x

