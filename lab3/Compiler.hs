{-# OPTIONS_GHC -Wall #-}

{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}

module Compiler where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.RWS

import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map

import CPP.Print (printTree)
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
  , limitStack    = 100
  , currentStack  = 0
  , currentAddr   = 0
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
  :: String   -- ^ Class name.
  -> Program  -- ^ Type-annotated program.
  -> IO ()    -- ^ Generated jasmin source file content.
compile name prg@(PDefs defs) = do
  writeFile jasminFile $ unlines w
  callProcess "jasmin" ["-d", takeDirectory jasminFile, jasminFile]
  where
    sigEntry def@(DFun _ f@(Id x) _ _ ) = (f, Fun (Id $ takeFileName name ++ "/" ++ x) $ funType def)
    sig     = Map.fromList $ builtin ++ map sigEntry defs
    w = snd $ evalRWS (compileProgram name prg) sig initSt
    jasminFile   = addExtension name "j"

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
  tell [ "", ".method public static " ++ toJVMF (Fun f $ funType def) ]

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


compileStm :: Type -> Stm -> Compile ()
compileStm t s = do

  -- Printing a comment
  let top = stmTop s
  unless (null top) $ do
    tell $ map (";; " ++) $ lines top
    --case s of SDecls{} -> return(); _ -> blank

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
      loop <- newLabel
      end <- newLabel
      emit (Label loop) >> compileExp e >> emit (IfZ "eq" end)
      newBlock >> compileStm t s' >> exitBlock >> emit (Goto loop)
      emit (Label end)

    SIfElse e s' s'' -> do
      els <- newLabel
      end <- newLabel
      compileExp e
      emit (IfZ "eq" els)
      newBlock >> compileStm t s' >> emit (Goto end)
      emit (Label els) >> compileStm t s'' >> exitBlock
      emit (Label end)

    where
      newBlock = do
        cs <- gets cxt
        modify $ \ st' -> st' {cxt = Map.empty:cs}

      exitBlock = do
        (_:cs) <- gets cxt
        modify $ \ st' -> st' {cxt = cs}


-- | Compiling and expression.
compileExp :: Exp -> Compile ()
compileExp = \case
    ETrue -> emit (IConst 1)

    EFalse -> emit (IConst 0)

    EInt i -> emit (IConst i)

    EId x -> do
      val <- lookupVar x
      emit (Load val)

    EApp f es -> do
      mapM_ compileExp es
      sig <- ask
      let Just fun = Map.lookup f sig
      emit (Call fun)

    EPostIncr i -> do
      x <- lookupVar i
      emit (Load x)
      emit (Load x)
      emit (IConst 1)
      emit (Add)
      emit (Store x)

    EPostDecr i -> do
      x <- lookupVar i
      emit (Load x)
      emit (Load x)
      emit (IConst 1)
      emit (Sub)
      emit (Store x)

    EPreIncr i -> do
      x <- lookupVar i
      emit (Load x)
      emit (IConst 1)
      emit (Add)
      emit (Store x)
      emit (Load x)

    EPreDecr i -> do
      x <- lookupVar i
      emit (Load x)
      emit (IConst 1)
      emit (Sub)
      emit (Store x)
      emit (Load x)

    ETimes e1 e2  -> arithOp e1 e2 (Mul)
    EDiv e1 e2    -> arithOp e1 e2 (Div)
    EPlus e1 e2   -> arithOp e1 e2 (Add)
    EMinus e1 e2  -> arithOp e1 e2 (Sub)

    ELt e1 e2     -> numOp e1 e2 "lt"
    EGt e1 e2     -> numOp e1 e2 "gt"
    ELtEq e1 e2   -> numOp e1 e2 "le"
    EGtEq e1 e2   -> numOp e1 e2 "ge"
    EEq e1 e2     -> numOp e1 e2 "eq"
    ENEq e1 e2    -> numOp e1 e2 "ne"

    EAnd e1 e2    -> logicOp e1 e2 "eq"
    EOr e1 e2     -> logicOp e1 e2 "ne"

    EAss i e -> do
      compileExp e
      x <- lookupVar i
      emit (Dup)
      emit (Store x)

    _ -> fail $ "doubles nyi"

    where
      arithOp e1 e2 op = do
        compileExp e1
        compileExp e2
        emit (op)

      numOp e1 e2 op = do
        end <- newLabel
        emit (IConst 1) >> compileExp e1 >> compileExp e2
        emit (IfS op end)
        emit (Pop)
        emit (IConst 0)
        emit (Label end)

      logicOp e1 e2 op = do
        end <- newLabel
        if (op == "eq") then emit (IConst 0) else emit (IConst 1)
        compileExp e1 >> emit (IfZ op end)
        compileExp e2 >> emit (IfZ op end)
        emit (Pop)
        if (op == "eq") then emit (IConst 1) else emit (IConst 0)
        emit (Label end)

-- * Instructions and emitting

type Addr = Int

data Code
  = Store Addr        -- ^ Store stack content of type @Type@ in local variable @Addr@.
  | Load Addr         -- ^ Push stack content of type @Type@ from local variable @Addr@.

  | IConst Integer    -- ^ Put integer constant on the stack.
  | Pop               -- ^ Pop something of type @Type@ from the stack.
  | Return            -- ^ Return from method of type @Type@.
  | Add               -- ^ Add 2 top values of stack.

  | Call Fun          -- ^ Call function.

  | Label Label       -- ^ Define label.
  | Goto Label        -- ^ Jump to label.
  | IfZ String Label  -- ^ If top of stack is 0, jump to label.
  | IfS String Label  -- ^ If prev <  top, jump.
  | Dup
  | Sub
  | Mul
  | Div

  --deriving(Show)

-- | Print a single instruction.  Also update stack limits
emit :: Code -> Compile ()
emit c = do
  tell [toJVM c]
  case c of
    Store _  -> modStack (-1)
    Load  _  -> modStack (1)
    IConst _ -> modStack (1)
    Dup      -> modStack (1)
    Pop      -> modStack (-1)
    Return   -> modStack (-1)
    Call _   -> modStack (-1)
    Add      -> modStack (-1)
    Sub      -> modStack (-1)
    Mul      -> modStack (-1)
    Div      -> modStack (-1)
    IfZ _ _  -> modStack (-1)
    IfS _ _  -> modStack (-2)
    _        -> return ()

-- * Labels

newLabel :: Compile Label
newLabel = do
  l <- gets nextLabel
  modify $ \ st -> st { nextLabel = succ l }
  return $ l

-- | Print top part of statement (for comments)

stmTop :: Stm -> String
stmTop s =
  case s of
    SWhile e _ -> "while (" ++ printTree e ++ ")"
    SIfElse e _ _  -> "if (" ++ printTree e ++ ")"
    SBlock _   -> ""
    _ -> printTree s

grabOutput :: Compile () -> Compile Output
grabOutput m = do
  r <- ask
  s <- get
  let ((), s', w) = runRWS m r s
  put s'
  return w

funType :: Def -> FunType
funType (DFun t _ args _) = FunType t $ map (\ (ADecl t' _) -> t') args

modStack :: Int -> Compile ()
modStack n = do
  new <- gets currentStack
  old <- gets limitStack
  modify $ \ st -> st { currentStack = new+n }
  when (new+n > old) $
    modify $ \ st -> st { limitStack = new+n }


toJVM :: Code -> String
toJVM c = case c of
  Store n   -> "istore " ++ show n
  Load  n   -> "iload " ++ show n
  Dup       -> "dup"
  Pop       -> "pop"
  Return    -> "ireturn"
  Call f    -> "invokestatic " ++ toJVMF f
  IConst i  -> "ldc " ++ show i
  Add       -> "iadd"
  Sub       -> "isub"
  Mul       -> "imul"
  Div       -> "idiv"
  Label l   -> toJVML l ++ ":"
  Goto l    -> "goto " ++ toJVML l
  IfZ s l   -> "if" ++ s ++ " " ++ toJVML l
  IfS s l   -> "if_icmp" ++ s ++ " " ++ toJVML l
  where
    toJVML (L l) = "L" ++ show l

toJVMT :: Type -> String
toJVMT t = case t of
  Type_int    -> "I"
  Type_bool   -> "Z"
  Type_void   -> "V"
  _           -> "D"

toJVMFT :: FunType -> String
toJVMFT (FunType t ts) = "(" ++ (toJVMT =<< ts) ++ ")" ++ toJVMT t

toJVMF :: Fun -> String
toJVMF (Fun (Id f) t) = f ++ toJVMFT t

newVar :: Id -> Compile ()
newVar x = do
  s <- get
  let (c:cs)  = cxt s
      a       = currentAddr s
  modify $ \ s' -> s' {
                        cxt = (Map.insert x a c):cs
                      , currentAddr = a + 1
                      }

lookupVar :: Id -> Compile Addr
lookupVar x = do
  cs <- gets cxt
  case catMaybes $ map (Map.lookup x) cs of
    [] -> error $ show x ++ " variable not declared in scope"
    (a:_) -> return a
