module Main where

import Eval
import Parser
import Syntax
import TypeCheck

import System.Environment
import System.Console.Haskeline

main :: IO ()
main = repl

repl = do
  putStrLn "------------------------------ STLC repl ------------------------------"
  putStrLn "Evaluates expressions to a function with no argument or to an integer."
  putStrLn "Type 'q' to quit."
  putStrLn "-----------------------------------------------------------------------"
  runInputT defaultSettings loop
  where
    loop :: InputT IO ()
    loop = do
      input <- getInputLine "stlc> "
      case input of
        Nothing  -> return ()
        Just "q" -> return ()
        Just input -> do
          let e = parseExp input
          case fst (runTc e) of
            Left err -> do {outputStrLn $ show err; loop}
            Right x  -> do {outputStrLn $ pprint (eval e); loop}
