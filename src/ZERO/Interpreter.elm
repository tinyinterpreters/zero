module ZERO.Interpreter exposing
    ( Error(..)
    , Value(..)
    , run
    )

import ZERO.AST as AST exposing (..)
import ZERO.Parser as P


type Value
    = VNumber Number
    | VBool Bool


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
        NExpr n ->
            VNumber <| runNExpr n

        BExpr b ->
            VBool <| runBExpr b


runNExpr : NExpr -> Number
runNExpr expr =
    case expr of
        Const n ->
            n

        Diff a b ->
            runNExpr a - runNExpr b


runBExpr : BExpr -> Bool
runBExpr expr =
    case expr of
        Zero a ->
            runNExpr a == 0
