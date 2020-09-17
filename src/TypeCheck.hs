module TypeCheck where

import Syntax

import Control.Monad.Except
import Control.Monad.State
import Data.List (find)

import qualified Data.Map as Map

type Tc a = ExceptT Error (State Ctx) a

type Ctx = [(Name, Ty)]

data Error
  = TError Ty Ty String
  | FError Ty String
  | DError Name String
  deriving (Eq, Show)

-- | Tries to return a type for a given name in the context.
getName :: Name -> Ctx -> Tc Ty
getName n ctx = case find ((== n) . fst) ctx of
  Just (_, t) -> return t
  Nothing     -> throwError $ DError n ("Name " ++ n ++ " not in context.")

-- | Run the typechecker.
runTc :: Exp -> (Either Error Ty, Ctx)
runTc e = (runState . runExceptT) (typeCheck e) []

-- | Typecheck expressions.
typeCheck :: Exp -> Tc Ty
typeCheck (Const i)   = return TyInt
typeCheck (Var n)     = do
  ctx <- get
  getName n ctx
typeCheck (Lam n t e) = do
  ctx <- get
  put $ (n, t):(ctx)
  ce <- typeCheck e
  put $ ctx
  return (t :-> ce)
typeCheck (App e1 e2) = do
  ce1 <- typeCheck e1
  ce2 <- typeCheck e2
  case ce1 of
    (t :-> res) -> case t == ce2 of
                     True  -> return res
                     False -> throwError $ TError ce1 ce2
                                           ("Expected " ++ show t ++ " but got " ++
                                            show ce2 ++ " as an argument for " ++
                                            show ce1)
    wt -> throwError $ FError wt ("Expected a function type but got " ++ show wt)
