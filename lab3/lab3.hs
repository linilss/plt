import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.FilePath (dropExtension, takeFileName)

import CPP.Lex
import CPP.Par
import CPP.ErrM
import CPP.Abs

import TypeChecker
import Compiler

check :: Program -> IO Program
check tree = 
  case typecheck tree of
    Bad err -> do
      putStrLn "TYPE ERROR"
      putStrLn err
      exitFailure
    Ok _ -> return tree

parse :: String -> IO Program
parse s = do
  case pProgram (myLexer s) of
    Bad err  -> do
      putStrLn "SYNTAX ERROR"
      putStrLn err
      exitFailure
    Ok  tree -> return tree

compileProg :: FilePath -> Program -> IO ()
compileProg file tree = do
  compile file tree

main :: IO ()
main = do
  args <- getArgs
  case args of
    [file] -> readFile file >>= parse >>= check >>= compileProg (dropExtension file)
    _      -> do
      putStrLn "Usage: lab3 <SourceFile>"
      exitFailure