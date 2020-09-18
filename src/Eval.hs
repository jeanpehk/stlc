module Eval where

import Syntax

-- | Bind a name to an expression.
data Bind = B { name :: Name, to :: Exp}
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
app (Var n) e2     = error $ "Unbound variable " ++ n
app (Lam n _ e) e2 = subst (B n e2) e
app (App e1 e2) e' = App (app e1 e2) e'

-- | Perform a substitution.
subst :: Bind -> Exp -> Exp
subst b ine = case ine of
  Const i   -> Const i
  Var n     -> if name b == n then to b else ine
  Lam n t e -> if name b == n then ine else Lam n t (subst b e)
  App e1 e2 -> App (subst b e1) (subst b e2)

-- | Small step reduce until we have a value.
eval :: Exp -> Exp
eval e = case step e of
           Just x  -> eval x
           Nothing -> e
