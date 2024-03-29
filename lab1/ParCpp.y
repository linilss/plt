-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParCpp where
import AbsCpp
import LexCpp
import ErrM

}

%name pProgram Program
%name pListDef ListDef
%name pDef Def
%name pListArg ListArg
%name pListStm ListStm
%name pListId ListId
%name pArg Arg
%name pStm Stm
%name pListString ListString
%name pListVar ListVar
%name pVar Var
%name pExp15 Exp15
%name pExp14 Exp14
%name pExp13 Exp13
%name pExp12 Exp12
%name pExp11 Exp11
%name pExp10 Exp10
%name pExp9 Exp9
%name pExp8 Exp8
%name pExp4 Exp4
%name pExp3 Exp3
%name pExp2 Exp2
%name pExp1 Exp1
%name pExp Exp
%name pExp5 Exp5
%name pExp6 Exp6
%name pExp7 Exp7
%name pListExp ListExp
%name pPType PType
%name pRType RType
%name pType Type
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '!' { PT _ (TS _ 1) }
  '!=' { PT _ (TS _ 2) }
  '%' { PT _ (TS _ 3) }
  '&' { PT _ (TS _ 4) }
  '&&' { PT _ (TS _ 5) }
  '(' { PT _ (TS _ 6) }
  ')' { PT _ (TS _ 7) }
  '*' { PT _ (TS _ 8) }
  '+' { PT _ (TS _ 9) }
  '++' { PT _ (TS _ 10) }
  '+=' { PT _ (TS _ 11) }
  ',' { PT _ (TS _ 12) }
  '-' { PT _ (TS _ 13) }
  '--' { PT _ (TS _ 14) }
  '-=' { PT _ (TS _ 15) }
  '->' { PT _ (TS _ 16) }
  '.' { PT _ (TS _ 17) }
  '/' { PT _ (TS _ 18) }
  ':' { PT _ (TS _ 19) }
  '::' { PT _ (TS _ 20) }
  ';' { PT _ (TS _ 21) }
  '<' { PT _ (TS _ 22) }
  '<<' { PT _ (TS _ 23) }
  '<=' { PT _ (TS _ 24) }
  '=' { PT _ (TS _ 25) }
  '==' { PT _ (TS _ 26) }
  '>' { PT _ (TS _ 27) }
  '>=' { PT _ (TS _ 28) }
  '>>' { PT _ (TS _ 29) }
  '?' { PT _ (TS _ 30) }
  '[' { PT _ (TS _ 31) }
  ']' { PT _ (TS _ 32) }
  'bool' { PT _ (TS _ 33) }
  'char' { PT _ (TS _ 34) }
  'const' { PT _ (TS _ 35) }
  'do' { PT _ (TS _ 36) }
  'double' { PT _ (TS _ 37) }
  'else' { PT _ (TS _ 38) }
  'false' { PT _ (TS _ 39) }
  'for' { PT _ (TS _ 40) }
  'if' { PT _ (TS _ 41) }
  'int' { PT _ (TS _ 42) }
  'return' { PT _ (TS _ 43) }
  'throw' { PT _ (TS _ 44) }
  'true' { PT _ (TS _ 45) }
  'typedef' { PT _ (TS _ 46) }
  'using' { PT _ (TS _ 47) }
  'void' { PT _ (TS _ 48) }
  'while' { PT _ (TS _ 49) }
  '{' { PT _ (TS _ 50) }
  '||' { PT _ (TS _ 51) }
  '}' { PT _ (TS _ 52) }

L_quoted { PT _ (TL $$) }
L_integ  { PT _ (TI $$) }
L_doubl  { PT _ (TD $$) }
L_charac { PT _ (TC $$) }
L_Id { PT _ (T_Id _) }


%%

String  :: { String }  : L_quoted {  $1 }
Integer :: { Integer } : L_integ  { (read ( $1)) :: Integer }
Double  :: { Double }  : L_doubl  { (read ( $1)) :: Double }
Char    :: { Char }    : L_charac { (read ( $1)) :: Char }
Id    :: { Id} : L_Id { Id (mkPosToken $1)}

Program :: { Program }
Program : ListDef { AbsCpp.PDefs (reverse $1) }
ListDef :: { [Def] }
ListDef : {- empty -} { [] } | ListDef Def { flip (:) $1 $2 }
Def :: { Def }
Def : Type Id '(' ListArg ')' '{' ListStm '}' { AbsCpp.DFun $1 $2 $4 (reverse $7) }
    | Type Id '(' ListArg ')' ';' { AbsCpp.DFunBody $1 $2 $4 }
    | 'using' ListId ';' { AbsCpp.DUsing $2 }
    | Type ListVar ';' { AbsCpp.DInit $1 $2 }
    | 'typedef' Type Id ';' { AbsCpp.DTD $2 $3 }
ListArg :: { [Arg] }
ListArg : {- empty -} { [] }
        | Arg { (:[]) $1 }
        | Arg ',' ListArg { (:) $1 $3 }
ListStm :: { [Stm] }
ListStm : {- empty -} { [] } | ListStm Stm { flip (:) $1 $2 }
ListId :: { [Id] }
ListId : Id { (:[]) $1 } | Id '::' ListId { (:) $1 $3 }
Arg :: { Arg }
Arg : Type Var { AbsCpp.ADecl $1 $2 }
    | Type { AbsCpp.ADeclInit $1 }
Stm :: { Stm }
Stm : Exp ';' { AbsCpp.SExp $1 }
    | Type ListVar ';' { AbsCpp.SInit $1 $2 }
    | 'return' Exp ';' { AbsCpp.SReturn $2 }
    | 'while' '(' Exp ')' Stm { AbsCpp.SWhile $3 $5 }
    | '{' ListStm '}' { AbsCpp.SBlock (reverse $2) }
    | 'if' '(' Exp ')' Stm { AbsCpp.SIf $3 $5 }
    | 'if' '(' Exp ')' Stm 'else' Stm { AbsCpp.SIfElse $3 $5 $7 }
    | 'for' '(' Type ListVar ';' Exp ';' Exp ')' Stm { AbsCpp.SFor $3 $4 $6 $8 $10 }
    | 'do' Stm 'while' '(' Exp ')' ';' { AbsCpp.SDoWhile $2 $5 }
    | 'typedef' Type Id ';' { AbsCpp.STD $2 $3 }
ListString :: { [String] }
ListString : String { (:[]) $1 } | String ListString { (:) $1 $2 }
ListVar :: { [Var] }
ListVar : Var { (:[]) $1 } | Var ',' ListVar { (:) $1 $3 }
Var :: { Var }
Var : Id { AbsCpp.VarDecl $1 }
    | Id '=' Exp { AbsCpp.VarInit $1 $3 }
Exp15 :: { Exp }
Exp15 : Integer { AbsCpp.EInt $1 }
      | Double { AbsCpp.EDouble $1 }
      | ListString { AbsCpp.EString $1 }
      | 'true' { AbsCpp.ETrue }
      | 'false' { AbsCpp.EFalse }
      | Char { AbsCpp.EChar $1 }
      | ListId { AbsCpp.EQCon $1 }
      | '(' Exp ')' { $2 }
Exp14 :: { Exp }
Exp14 : Exp14 '(' ListExp ')' { AbsCpp.ECall $1 $3 }
      | Exp14 '.' Exp15 { AbsCpp.EStrDot $1 $3 }
      | Exp14 '->' Exp15 { AbsCpp.EStrArr $1 $3 }
      | Exp14 '[' Exp ']' { AbsCpp.EIdx $1 $3 }
      | Exp14 '++' { AbsCpp.EPIncr $1 }
      | Exp14 '--' { AbsCpp.EPDecr $1 }
      | Exp15 { $1 }
Exp13 :: { Exp }
Exp13 : '++' Exp13 { AbsCpp.EIncr $2 }
      | '--' Exp13 { AbsCpp.EDecr $2 }
      | '!' Exp13 { AbsCpp.ENeg $2 }
      | '*' Exp13 { AbsCpp.EMul $2 }
      | Exp14 { $1 }
Exp12 :: { Exp }
Exp12 : Exp12 '*' Exp13 { AbsCpp.ETimes $1 $3 }
      | Exp12 '/' Exp13 { AbsCpp.EDiv $1 $3 }
      | Exp12 '%' Exp13 { AbsCpp.EMod $1 $3 }
      | Exp13 { $1 }
Exp11 :: { Exp }
Exp11 : Exp11 '+' Exp12 { AbsCpp.EPlus $1 $3 }
      | Exp11 '-' Exp12 { AbsCpp.EMinus $1 $3 }
      | Exp12 { $1 }
Exp10 :: { Exp }
Exp10 : Exp10 '>>' Exp11 { AbsCpp.ERS $1 $3 }
      | Exp10 '<<' Exp11 { AbsCpp.ELS $1 $3 }
      | Exp11 { $1 }
Exp9 :: { Exp }
Exp9 : Exp9 '<' Exp10 { AbsCpp.ELt $1 $3 }
     | Exp9 '>' Exp10 { AbsCpp.EGt $1 $3 }
     | Exp9 '<=' Exp10 { AbsCpp.ELtEq $1 $3 }
     | Exp9 '>=' Exp10 { AbsCpp.EGtWq $1 $3 }
     | Exp10 { $1 }
Exp8 :: { Exp }
Exp8 : Exp8 '==' Exp9 { AbsCpp.EEq $1 $3 }
     | Exp8 '!=' Exp9 { AbsCpp.ENEq $1 $3 }
     | Exp9 { $1 }
Exp4 :: { Exp }
Exp4 : Exp4 '&&' Exp5 { AbsCpp.EAnd $1 $3 } | Exp5 { $1 }
Exp3 :: { Exp }
Exp3 : Exp3 '||' Exp4 { AbsCpp.EOr $1 $3 } | Exp4 { $1 }
Exp2 :: { Exp }
Exp2 : Exp3 '=' Exp2 { AbsCpp.EAss $1 $3 }
     | Exp3 '+=' Exp2 { AbsCpp.EAssAdd $1 $3 }
     | Exp3 '-=' Exp2 { AbsCpp.EAssSub $1 $3 }
     | Exp3 '?' Exp2 ':' Exp2 { AbsCpp.ECond $1 $3 $5 }
     | Exp3 { $1 }
Exp1 :: { Exp }
Exp1 : 'throw' Exp { AbsCpp.EThrow $2 } | Exp2 { $1 }
Exp :: { Exp }
Exp : Exp1 { $1 }
Exp5 :: { Exp }
Exp5 : Exp6 { $1 }
Exp6 :: { Exp }
Exp6 : Exp7 { $1 }
Exp7 :: { Exp }
Exp7 : Exp8 { $1 }
ListExp :: { [Exp] }
ListExp : {- empty -} { [] }
        | Exp { (:[]) $1 }
        | Exp ',' ListExp { (:) $1 $3 }
PType :: { PType }
PType : 'bool' { AbsCpp.Tbool }
      | 'double' { AbsCpp.Tdouble }
      | 'int' { AbsCpp.Tint }
      | 'void' { AbsCpp.Tvoid }
      | 'char' { AbsCpp.TChar }
      | ListId { AbsCpp.TQCon $1 }
RType :: { RType }
RType : PType { AbsCpp.TPType $1 } | RType '&' { AbsCpp.TRef $1 }
Type :: { Type }
Type : RType { AbsCpp.TRType $1 }
     | 'const' RType { AbsCpp.TConst $2 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}

