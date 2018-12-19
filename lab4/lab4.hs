import Control.Monad.State
import Control.Monad.Except

import System.IO
import System.FilePath.Posix
import System.Environment
import System.Exit

import FUN.Lex
import FUN.Par
import FUN.ErrM
import FUN.Abs          

import Interpreter 

-- | Entry point.

main :: IO ()
main = do
  args <- getArgs
  CmdLine strategy file <- mapM_ parseArg args `execStateT` initCmdLine
  when (null file) usage
  run strategy =<< readFile file

-- | Main pipeline.

run :: Strategy -> String -> IO ()
run strategy s = preEval strategy =<< parse s

-- | Parse.

parse :: String -> IO Program
parse s = case pProgram (myLexer s) of
  Bad err -> do
    putStrLn "SYNTAX ERROR"
    putStrLn err
    exitFailure
  Ok prg -> return prg


-- | Interpret in call-by-value or call-by-name.

preEval :: Strategy -> Program -> IO ()
preEval strategy prg = do
  case interpret strategy prg of
    Bad err -> do
      putStrLn "INTERPRETER ERROR"
      putStrLn err
      exitFailure
    Ok i -> do
      putStrLn $ show i
      hPutStrLn stderr "OK"
      exitSuccess

-- * Command-line parsing

-- | State of the command line parser.

data CmdLine = CmdLine
  { strategy :: Strategy
  , fileName :: FilePath
  }

-- | Initial state: 'CallByValue' is default.

initCmdLine :: CmdLine
initCmdLine = CmdLine
  { strategy = CallByValue
  , fileName = ""
  }

-- | Parse a single command line argument.

parseArg :: String -> StateT CmdLine IO ()
parseArg s
  | s == "-n" = modify $ \ o -> o { strategy = CallByName  }
  | s == "-v" = modify $ \ o -> o { strategy = CallByValue }
  | otherwise = do
      old <- gets fileName
      if null old then modify $ \ o -> o { fileName = s }
      else lift $ usage

-- | Print usage information and exit.

usage :: IO ()
usage = do
  putStrLn "Usage: lab4 [-n|-v] <SourceFile>"
  exitFailure
