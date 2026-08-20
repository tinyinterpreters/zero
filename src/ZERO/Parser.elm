module ZERO.Parser exposing (Error, parse)

import Parser as P exposing ((|.), (|=), Parser)
import ZERO.AST as AST exposing (..)
import ZERO.Lexer as L


type alias Error =
    List P.DeadEnd


parse : String -> Result Error AST.Program
parse =
    P.run program


program : Parser AST.Program
program =
    P.succeed Program
        |. L.spaces
        |= expr
        |. P.end


expr : Parser Expr
expr =
    P.oneOf
        [ P.map NExpr constExpr
        , P.map NExpr diffExpr
        , P.map BExpr zeroExpr
        ]


nExpr : Parser NExpr
nExpr =
    P.oneOf
        [ constExpr
        , diffExpr
        ]


constExpr : Parser NExpr
constExpr =
    P.map Const number


number : Parser Number
number =
    L.digits


diffExpr : Parser NExpr
diffExpr =
    P.succeed Diff
        |. L.symbol "-"
        |. L.symbol "("
        |= P.lazy (\_ -> nExpr)
        |. L.symbol ","
        |= P.lazy (\_ -> nExpr)
        |. L.symbol ")"


zeroExpr : Parser BExpr
zeroExpr =
    P.succeed Zero
        |. L.keyword "zero?"
        |. L.symbol "("
        |= P.lazy (\_ -> nExpr)
        |. L.symbol ")"
