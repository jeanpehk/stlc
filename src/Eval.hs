module Eval where

import Syntax

data Bind = B { getC :: Name, getE :: Exp }
  deriving (Eq, Show)

-- | Small step reduction.
step :: Exp -> Maybe Exp
step (Const i)   = Nothing
step (Var n)     = error $ "Unbound variable " ++ n
step (Lam n t e) = Nothing
step (App e1 e2) = Just $ app e1 e2

app :: Exp -> Exp -> Exp
app (Const i) e2   = error $ "Fix typechecker, can't apply "
                             ++ show e2 ++ " to " ++ show i
app (Var n) e2     = error $ "Unboudn variable " ++ n
app (Lam n _ e) e2 = subst (B n e) e2
app (App e1 e2) e' = App (app e1 e2) e2

-- | Perform a substitution.
subst :: Bind -> Exp -> Exp
subst b (Const i)   = Const i
subst b (Var n')
  | getC b == n'    = getE b
  | otherwise       = Var n'
subst b (Lam n' t e')
  | getC b == n'    = Lam n' t e'
  | otherwise       = Lam n' t (subst b e')
subst b (App e1 e2) = App (subst b e1) (subst b e2)
