module Syntax where

type Name = String

-- | Abstract syntax.
data Exp
  = Const Int
  | Var Name
  | Lam Name Ty Exp
  | App Exp Exp
  deriving (Eq, Show)

-- | Types.
data Ty
  = TyInt
  | Ty :-> Ty
  deriving (Eq, Show)
