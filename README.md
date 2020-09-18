# Simply Typed Lambda Calculus

A simple REPL demo implementation.

## Usage:

```haskell
stlc> (λy::Int.y) 1
1

stlc> (λy::Int->Int.y 2) (λa::Int.a)
2

stlc> (λa::Int.3) 0
3

## Build

To build with stack:

```bash
$ stack build
```

## Run

Run repl with stack:

```bash
$ stack exec stlc-exe
```

Or execute 'main' function in [src/Main.hs](src/Main.hs) with ghci.
