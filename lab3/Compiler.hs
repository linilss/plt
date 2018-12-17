{-# OPTIONS_GHC -Wall #-}

{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}

module Compiler where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.RWS

--import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map

--import Annotated
import CPP.Abs --(Type(..), Id(..), Arg(..))
--import TypeChecker (FunType(..))

import System.Process (callProcess)
import System.FilePath.Posix (addExtension)
import System.FilePath (takeFileName, takeDirectory)

data St = St
  { cxt           :: Cxt   -- ^ Context.
  , limitLocals   :: Int   -- ^ Maximal size for locals encountered.
  , currentStack  :: Int   -- ^ Current stack size.
  , currentAddr   :: Addr
  , limitStack    :: Int   -- ^ Maximal stack size encountered.
  , nextLabel     :: Label -- ^ Next jump label (persistent part of state)
  }

type Sig = Map Id Fun

data Fun = Fun { funId :: Id , funFunType :: FunType }

type Cxt = [Block]
type Block = Map Id Addr

data FunType = FunType Type [Type]

newtype Label = L { theLabel :: Int }
  deriving (Eq, Enum, Show)

initSt :: St
initSt = St
  { cxt           = [Map.empty]
  , limitLocals   = 100
  , currentStack  = 0
  , currentAddr   = 0
  , limitStack    = 0
  , nextLabel     = L 0
  }

type Output = [String]

type Compile = RWS Sig Output St

  -- | Builtin-functions
builtin :: [(Id, Fun)]
builtin =
  [ (Id "printInt" , Fun (Id "Runtime/printInt"  ) $ FunType Type_void [Type_int]),
    (Id "readInt"  , Fun (Id "Runtime/readInt"   ) $ FunType Type_int [])
  ]



-- | Entry point.

compile
  :: String  -- ^ Class name.
  -> Program -- ^ Type-annotated program.
  -> IO ()  -- ^ Generated jasmin source file content.
compile name prg@(PDefs defs) = do
  let sig = Map.fromList $
        builtin ++
        map (\ def@(DFun _ f@(Id x) _ _ ) -> (f, Fun (Id $ takeFileName name ++ "/" ++ x) $ funType def)) defs
      ((), w) = evalRWS (compileProgram name prg) sig initSt
  -- Write to .j file and call jasmin
      jfile = addExtension name "j"
  writeFile jfile $ unlines w
  callProcess "jasmin" ["-d", takeDirectory jfile, jfile]

compileProgram :: String -> Program -> Compile ()
compileProgram name (PDefs defs) = do
  tell header
  mapM_ compileFun defs
  where
  header =
    [ ";; BEGIN HEADER"
    , ""
    , ".class public " ++ takeFileName name
    , ".super java/lang/Object"
    , ""
    , ".method public <init>()V"
    , "  .limit locals 1"
    , ""
    , "  aload_0"
    , "  invokespecial java/lang/Object/<init>()V"
    , "  return"
    , ""
    , ".end method"
    , ""
    , ".method public static main([Ljava/lang/String;)V"
    , "  .limit locals 1"
    , "  .limit stack  1"
    , ""
    , "  invokestatic " ++ takeFileName name ++ "/main()I"
    , "  pop"
    , "  return"
    , ""
    , ".end method"
    , ""
    , ";; END HEADER"
    ]

compileFun :: Def -> Compile ()
compileFun def@(DFun t f args ss) = do
  -- function header
  tell [ "", ".method public static " ++ toJVM (Fun f $ funType def) ]

  -- prepare environment
  lab <- gets nextLabel
  put initSt{ nextLabel = lab }
  mapM_ (\ (ADecl _ x) -> newVar x) args

  -- compile statements
  w <- grabOutput $ do
    mapM_ (compileStm t) ss

  -- output limits
  ll <- gets limitLocals
  ls <- gets limitStack
  tell [ "  .limit locals " ++ show ll
       , "  .limit stack  " ++ show ls
       ]

  -- output code, indented by 2
  tell $ map (\ s -> if null s then s else "  " ++ s) w

  -- function footer
  tell [ "return", ".end method"]

-- | Compiling a statement.

compileStm :: Type -> Stm -> Compile ()
compileStm t s = do
  -- Compile statement
  case s of

    SDecls _ xs -> do
      mapM_ newVar xs

    SInit _ x e -> do
      newVar x
      compileExp e
      a <- lookupVar x
      emit (Store a)

    SExp e -> do
      compileExp e
      case e of
        (EApp f _) -> do
          sig <- ask
          let Just (Fun (Id _) (FunType t' _)) = Map.lookup f sig
          case t' of
            Type_void -> return ()
            _         -> emit (Pop)
        _          -> emit (Pop)

    SReturn e -> do
      compileExp e
      case t of
        Type_void -> tell ["return"]
        _         -> emit (Return)

    SBlock ss -> do
      newBlock
      mapM_ (compileStm t) ss
      exitBlock

    SWhile e s' -> do
      enter <- newLabel
      end <- newLabel
      emit (Label enter)
      compileExp e
      emit (IfZ "eq" end)
      newBlock
      compileStm t s'
      exitBlock
      emit (Goto enter)
      emit (Label end)

    SIfElse e s' s'' -> do
      s2 <- newLabel
      end <- newLabel
      compileExp e
      emit (IfZ "eq" s2)
      newBlock
      compileStm t s'
      emit (Goto end)
      emit (Label s2)
      compileStm t s''
      exitBlock
      emit (Label end)

    where
      newBlock = do
        st <- get
        let cs = cxt st
        modify $ \ st' -> st' {cxt = Map.empty:cs}

      exitBlock = do
        st <- get
        let (_:cs) = cxt st
        modify $ \ st' -> st' {cxt = cs}


-- | Compiling and expression.
compileExp :: Exp -> Compile ()
compileExp = \case
    ETrue -> emit (IConst 1)

    EFalse -> emit (IConst 0)

    EInt i -> emit (IConst i)

    EId x -> do
      a <- lookupVar x
      emit (Load a)

    EApp f es -> do
      mapM_ compileExp es
      sig <- ask
      let Just fun = Map.lookup f sig
      emit (Call fun)

    EPostIncr x -> do
      a <- lookupVar x
      emit (Load a)
      emit (Load a)
      emit (IConst 1)
      emit (Add)
      emit (Store a)

    EPostDecr x -> do
      a <- lookupVar x
      emit (Load a)
      emit (Load a)
      emit (IConst 1)
      emit (Sub)
      emit (Store a)

    EPreIncr x -> do
      a <- lookupVar x
      emit (Load a)
      emit (IConst 1)
      emit (Add)
      emit (Store a)
      emit (Load a)

    EPreDecr x -> do
      a <- lookupVar x
      emit (Load a)
      emit (IConst 1)
      emit (Sub)
      emit (Store a)
      emit (Load a)

    ETimes e1 e2 -> arithOp e1 e2 (Mul)
    EDiv e1 e2 -> arithOp e1 e2 (Div)
    EPlus e1 e2 -> arithOp e1 e2 (Add)
    EMinus e1 e2 -> arithOp e1 e2 (Sub)
    ELt e1 e2 -> compareExp e1 e2 "lt"
    EGt e1 e2 -> compareExp e1 e2 "gt"
    ELtEq e1 e2 -> compareExp e1 e2 "le"
    EGtEq e1 e2 -> compareExp e1 e2 "ge"
    EEq e1 e2 -> compareExp e1 e2 "eq"
    ENEq e1 e2 -> compareExp e1 e2 "ne"
    EAnd e1 e2 -> binExp e1 e2 "eq"
    EOr e1 e2 -> binExp e1 e2 "ne"

    EAss x e -> do
      compileExp e
      a <- lookupVar x
      emit (Dup)
      emit (Store a)

    _ -> fail "Doubles not implemented"

    where
      arithOp e1 e2 c = do
        compileExp e1
        compileExp e2
        emit (c)

      compareExp e1 e2 s = do
        end <- newLabel
        emit (IConst 1) >> compileExp e1 >> compileExp e2
        emit (IfS s end)
        emit (Pop)
        emit (IConst 0)
        emit (Label end)

      binExp e1 e2 s = do
        end <- newLabel
        case s of
          "eq" -> emit (IConst 0)
          "ne" -> emit (IConst 1)
          _    -> fail "Only eq or ne is allowed"
        compileExp e1
        emit (IfZ s end)
        compileExp e2
        emit (IfZ s end)
        case s of
          "eq" -> emit (IConst 1)
          "ne" -> emit (IConst 0)
          _    -> fail "Only eq or ne is allowed"
        emit (Label end)

type Addr = Int

data Code
  = Store Addr        -- ^ Store stack content of type @Type@ in local variable @Addr@.
  | Load Addr         -- ^ Push stack content of type @Type@ from local variable @Addr@.

  | IConst Integer    -- ^ Put integer constant on the stack.
  | Pop               -- ^ Pop something of type @Type@ from the stack.
  | Return            -- ^ Return from method of type @Type@.
  | Add               -- ^ Add 2 top values of stack.

  | Call Fun          -- ^ Call function.

  | Label Label        -- ^ Define label.
  | Goto Label        -- ^ Jump to label.
  | IfZ String Label   -- ^ If top of stack is 0, jump to label.
  | IfS String Label  -- ^ If prev <  top, jump.
  | Dup
  | Sub               -- ^ Sub 2 top values of stack.
  | Mul
  | Div

-- | Print a single instruction.  Also update stack limits
emit :: Code -> Compile ()
emit c = do
  tell [toJVM c]
  case c of
    Store _  -> modStack (-1)
    Load  _  -> modStack (1)
    IConst _  -> modStack (1)
    Dup      -> modStack (1)
    Pop      -> modStack (-1)
    Return   -> modStack (-1)
    Call _   -> modStack (-1)
    Add      -> modStack (-1)
    Sub      -> modStack (-1)
    Mul      -> modStack (-1)
    Div      -> modStack (-1)
    IfZ _ _   -> modStack (-1)
    IfS _ _  -> do
      modStack (-1)
      modStack (-1)
    _        -> return ()

newLabel :: Compile Label
newLabel = do
  s <- get
  let (L l) = nextLabel s
  modify $ \ s' -> s' {nextLabel = (L (l + 1))}
  return (L l)

grabOutput :: Compile () -> Compile Output
grabOutput m = do
  r <- ask
  s <- get
  let ((), s', w) = runRWS m r s
  put s'
  return w

funType :: Def -> FunType
funType (DFun t _ args _) = FunType t $ map (\ (ADecl t' _) -> t') args

instance ToJVM Code where
  toJVM c = case c of
    Store n   -> "istore " ++ show n
    Load  n   -> "iload " ++ show n
    Dup       -> "dup"
    Pop       -> "pop"
    Return    -> "ireturn"
    Call f    -> "invokestatic " ++ toJVM f
    IConst i   -> "ldc " ++ show i
    Add       -> "iadd"
    Sub       -> "isub"
    Mul       -> "imul"
    Div       -> "idiv"
    Label l    -> toJVM l ++ ":"
    Goto l    -> "goto " ++ toJVM l
    IfZ s l    -> "if" ++ s ++ " " ++ toJVM l
    IfS s l   -> "if_icmp" ++ s ++ " " ++ toJVM l


modStack :: Int -> Compile ()
modStack n = do
  new <- gets currentStack
  modify $ \ st -> st { currentStack = new+n }
  old <- gets limitStack
  when (new+n > old) $
    modify $ \ st -> st { limitStack = new+n }

class ToJVM a where
  toJVM :: a -> String

instance ToJVM Type where
  toJVM t = case t of
    Type_int    -> "I"
    Type_void   -> "V"
    Type_bool   -> "Z"
    Type_double -> "D"

instance ToJVM FunType where
  toJVM (FunType t ts) = "(" ++ (toJVM =<< ts) ++ ")" ++ toJVM t

instance ToJVM Fun where
  toJVM (Fun (Id f) t) = f ++ toJVM t

instance ToJVM Label where
  toJVM (L l) = "L" ++ show l

newVar :: Id -> Compile ()
newVar x = do
  s <- get
  let (c:cs)  = cxt s
      a       = currentAddr s
  modify $ \ s' -> s' {cxt = (Map.insert x a c):cs
                      ,currentAddr = a + 1}

lookupVar :: Id -> Compile Addr
lookupVar x = do
  s <- get
  let cs = cxt s
  lookupVar' x cs

lookupVar' :: Id -> Cxt -> Compile Addr
lookupVar' x [] = fail $ "could not find variable: " ++ show x
lookupVar' x (c:cs) = do
  case Map.lookup x c of
    Just a -> return a
    Nothing -> lookupVar' x cs
