{
module Lexer where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$eol = [\n]

tokens :-
  
  $eol                                ;
  $white+                             ;
  "--".*                              ;

  $digit+                             { \s -> TokenInt (read s) }
  "->"                                { \s -> TokenArrow }
  \\                                  { \s -> TokenLambda }
  \(                                  { \s -> TokenLParen }
  \)                                  { \s -> TokenRParen }
  $alpha [$alpha $digit \_ \']*       { \s -> TokenVar s }

{

data Token
  = TokenArrow
  | TokenInt Int
  | TokenLambda
  | TokenLParen
  | TokenRParen
  | TokenVar String
  deriving (Eq, Show)

printLex = do
  s <- getContents
  print (alexScanTokens s)

}
