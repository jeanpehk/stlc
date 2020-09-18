# Simply typed lambda calculus

A simple REPL demo implementation.

## Syntax

Lambda-abstraction:

\y::Type.'lambda-term' | λ::Type.'lambda-term' | ('lambda-abstraction')

Application:

'lambda-term' 'lambda-term'

Variable:

'string'

Type:

Int | Type '->' Type

## Building

To build with stack:

```bash
$ stack build
```

## Running

Run repl with stack:

```bash
$ stack exec stlc-exe
```

Or execute 'main' function in [src/Main.hs](src/Main.hs) with ghci.
