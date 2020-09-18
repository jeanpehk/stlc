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

class PPrint a where
  pprint :: a -> String

instance PPrint Exp where
  pprint (Const i)   = show i
  pprint (Var n)     = n
  pprint (Lam n t e) = "λ" ++ n ++ "::" ++ pprint t ++ "." ++ pprint e
  pprint (App e1 e2) = pprint e1 ++ " " ++ pprint e2

instance PPrint Ty where
  pprint TyInt = "Int"
  pprint (t1 :-> t2) = pprint t1 ++ "->" ++ pprint t2
