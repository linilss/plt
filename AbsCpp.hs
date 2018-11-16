

module AbsCpp where

-- Haskell module generated by the BNF converter




newtype Ref = Ref ((Int,Int),String) deriving (Eq, Ord, Show, Read)
newtype Id = Id ((Int,Int),String) deriving (Eq, Ord, Show, Read)
data Program = PDefs [Def]
  deriving (Eq, Ord, Show, Read)

data Def = DUsing QId | DFun Type Id [Arg] [Stm]
  deriving (Eq, Ord, Show, Read)

data Arg = ADecl Type Id
  deriving (Eq, Ord, Show, Read)

data Stm
    = SExp Exp
    | STypedef Stm
    | SDecl Type Id
    | SDecls Type Id [Id]
    | SInit Type Id Exp
    | SReturn Exp
    | SWhile Exp Stm
    | SBlock [Stm]
    | SIf Exp Stm
    | SIfElse Exp Stm Stm
    | SUsing QId
    | SThr Exp
  deriving (Eq, Ord, Show, Read)

data Exp
    = EInt Integer
    | EString String
    | EStrings String Exp
    | EDouble Double
    | ETrue
    | EFalse
    | EQId QId
    | EStrProj Id Exp
    | ECall Id [Exp]
    | EPIncr Exp
    | EPDecr Exp
    | EIndex Id Exp
    | EIncr Exp
    | EDecr Exp
    | ENeg Exp
    | EMul Exp Exp
    | EDiv Exp Exp
    | EMod Exp Exp
    | EAdd Exp Exp
    | ESub Exp Exp
    | ERS Exp Exp
    | ELS Exp Exp
    | ELt Exp Exp
    | EGt Exp Exp
    | ELEq Exp Exp
    | EGEq Exp Exp
    | EEq Exp Exp
    | ENEq Exp Exp
    | EAnd Exp Exp
    | EOr Exp Exp
    | EAss Exp Exp
    | ECond Exp Exp Exp
  deriving (Eq, Ord, Show, Read)

data QId = QIdent Id | QIdElems [QIdElem]
  deriving (Eq, Ord, Show, Read)

data QIdElem = QIdElemId Id
  deriving (Eq, Ord, Show, Read)

data Type = Tbool | Tdouble | Tint | Tvoid | TQConst QId | TRef Ref
  deriving (Eq, Ord, Show, Read)

