module ZERO.Interpreter exposing (Error(..), Value(..), run)

import ZERO.AST as AST exposing (..)
import ZERO.Parser as P


type Value
    = VNumber Number


type Error
    = SyntaxError P.Error


run : String -> Result Error Value
run input =
    case P.parse input of
        Ok program ->
            Ok <| runProgram program

        Err err ->
            Err <| SyntaxError err


runProgram : AST.Program -> Value
runProgram (Program expr) =
    runExpr expr


runExpr : Expr -> Value
runExpr expr =
    case expr of
        Const n ->
            VNumber n

        Diff a b ->
            evalDiff (runExpr a) (runExpr b)


evalDiff : Value -> Value -> Value
evalDiff va vb =
    case ( va, vb ) of
        ( VNumber a, VNumber b ) ->
            VNumber <| a - b
