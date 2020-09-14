module Syntax where

type Name = String

data Exp
  = Const Int
  | Var Name
  | Lam Name Exp
  | App Exp Exp
  deriving (Eq, Show)

