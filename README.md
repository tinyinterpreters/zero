# DIFF

A tiny interpreter in Elm that evaluates recursive difference expressions.

Read [DIFF - Adding Recursive Expressions to a Tiny Interpreter in Elm](https://blog.tinyinterpreters.dev/posts/diff) for a guided explanation of how it works.

```mermaid
flowchart TD
    A["-(2, -(4, 3))"] -->|parse| B["Program (Diff (Const 2) (Diff (Const 4) (Const 3)))"]
    B -->|runProgram| C["VNumber 1"]
```

## Run it

You’ll need [Nix](https://nixos.org/) with flakes enabled.

```bash
nix develop
elm repl
```

Then, in the Elm REPL:

```elm
import DIFF.Interpreter as I

I.run "-(2, -(4, 3))"
-- Ok (VNumber 1)
```
