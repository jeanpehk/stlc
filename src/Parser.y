{

module Parser where

import Lexer
import Syntax

}

%name calc
%tokentype { Token }
%error { parseError }

%token
    int               { TokenInt $$ }
    var               { TokenVar $$ }
    Int               { TokenIntType }
    '.'               { TokenDot }
    '->'              { TokenArrow }
    '::'              { TokenIsOfType }
    '\\'              { TokenLambda }
    '('               { TokenLParen }
    ')'               { TokenRParen }
  
%%

Exp : '\\' var '::' Type '.' Exp            { Lam $2 $4 $6 }
    | Term                                  { $1 }

Term : Term Atom                            { App $1 $2 }
    | Atom                                  { $1 }

Atom : '(' Exp ')'                          { $2 }
     | int                                  { Const $1 }
     | var                                  { Var $1 }

Type : TyConst '->' Type                    { $1 :-> $3 }
     | TyConst                              { $1 }

TyConst : Int                               { TyInt }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

parseExp :: String -> Exp
parseExp inp = calc (alexScanTokens inp)

}
