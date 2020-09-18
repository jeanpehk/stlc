# Simply Typed Lambda Calculus

A simple REPL demo implementation.

Some simple usage examples:

```haskell
stlc> (λy::Int.y) 1
1

stlc> (λy::Int->Int.y 2) (λa::Int.a)
2

stlc> (λa::Int.3) 0
3
```
'\\' can also be used equivalently with 'λ'.

## Build

To build with stack:

```bash
$ stack build
```
