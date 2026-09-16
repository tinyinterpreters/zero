# ZERO

ZERO extends [DIFF](https://github.com/tinyinterpreters/diff) with the `zero?` predicate:

```txt
zero?(0)
```

`zero?` introduces Boolean values:

```txt
zero?(0)
→ true

zero?(1)
→ false
```

Once expressions can produce both numbers and Booleans, an operation can receive a value of the wrong type:

```txt
zero?(zero?(0))
```

The inner `zero?` produces a Boolean, but the outer `zero?` expects a number. ZERO introduces runtime type errors to handle cases like this.

For a closer look, read [ZERO: Boolean Values and Runtime Type Errors](https://blog.tinyinterpreters.dev/posts/zero/).

To try it, you'll need [Nix](https://zero-to-nix.com/start/install/) with flakes enabled.

```bash
nix develop
elm repl
```

Then:

```elm
import ZERO.Interpreter as I

I.run "zero?(-(1, 1))"
-- Ok (VBool True)
```
