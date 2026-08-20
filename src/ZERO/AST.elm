module ZERO.AST exposing
    ( BExpr(..)
    , Expr(..)
    , NExpr(..)
    , Number
    , Program(..)
    )


type Program
    = Program Expr


type Expr
    = NExpr NExpr
    | BExpr BExpr


type NExpr
    = Const Number
    | Diff NExpr NExpr


type BExpr
    = Zero NExpr


type alias Number =
    Int
