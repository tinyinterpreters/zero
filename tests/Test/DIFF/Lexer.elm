module Test.DIFF.Lexer exposing (suite)

import DIFF.Lexer as L
import Parser as P exposing (Parser)
import Test exposing (Test, describe)
import Test.Lib exposing (testValue)


suite : Test
suite =
    describe "DIFF.Lexer"
        [ describe "digits" <|
            List.map (testValue <| P.run L.digits)
                [ ( "123", Just 123 )
                , ( "123 ", Just 123 )
                , ( "123  ", Just 123 )
                , ( "123abc", Just 123 )
                , ( " 123", Nothing )
                , ( "onetwothree", Nothing )
                ]
        , symbolSuite
        ]


symbolSuite : Test
symbolSuite =
    let
        symbol : String -> Parser String
        symbol =
            L.symbol >> P.getChompedString
    in
    describe "symbol"
        [ describe "-" <|
            List.map (testValue <| P.run <| symbol "-")
                -- Exact match
                [ ( "-", Just "-" )

                -- Trailing spaces
                , ( "- ", Just "- " )
                , ( "-\n(1", Just "-\n" )

                -- Tabs are not spaces
                , ( "- \t\n", Just "- " )

                -- Only the symbol and spaces
                , ( "-(1", Just "-" )

                -- No match
                , ( "(-", Nothing )

                -- No leading spaces
                , ( " -", Nothing )
                ]
        ]
