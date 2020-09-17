module Main where

import Eval
import Parser
import TypeCheck

import System.Environment
import System.Console.Haskeline

main :: IO ()
main = repl

repl = do
  putStrLn "---------------------------- STLC repl ----------------------------"
  putStrLn "Syntax: (\\'var'::'Type'.'lam-body') 'argument', Type 'q' to quit."
  putStrLn "-------------------------------------------------------------------"
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
            Right x  -> do {outputStrLn $ show (eval e); loop}
