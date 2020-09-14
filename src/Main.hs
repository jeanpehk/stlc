module Main where

import Syntax
import Parser

main :: IO ()
main = putStrLn "todo"

test = parseExp "\\y -> y"
