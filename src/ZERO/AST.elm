module ZERO.AST exposing
    ( Expr(..)
    , Number
    , Program(..)
    )


type Program
    = Program Expr


type Expr
    = Const Number
    | Diff Expr Expr


type alias Number =
    Int
