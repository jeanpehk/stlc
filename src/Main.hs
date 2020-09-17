module Main where

import Eval
import Parser
import TypeCheck

main :: IO ()
main = putStrLn "todo"

test = do
  let e = parseExp "((\\y::Int->Int . y) (\\x::Int.x)) 2"
  case fst (runTc e) of
    Left err -> putStrLn $ show err
    Right rs -> putStrLn $ show $ eval e

