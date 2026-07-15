module Test.DIFF.Parser exposing (suite)

import DIFF.AST as AST exposing (..)
import DIFF.Parser as P
import Test exposing (Test, describe)
import Test.Lib exposing (testValue)


suite : Test
suite =
    describe "DIFF.Parser"
        [ describe "parse" <|
            List.map (testValue P.parse)
                -- Constant expressions
                [ ( "123", Just (Program (Const 123)) )
                , ( "123 ", Just (Program (Const 123)) )
                , ( "123  ", Just (Program (Const 123)) )
                , ( " 123", Just (Program (Const 123)) )
                , ( "  123", Just (Program (Const 123)) )
                , ( "123abc", Nothing )
                , ( "onetwothree", Nothing )

                -- Difference expressions
                , ( "-(456,123)", Just (Program (Diff (Const 456) (Const 123))) )
                , ( "-(456, 123)", Just (Program (Diff (Const 456) (Const 123))) )
                , ( "- ( 2, -( 4, 3 ) )", Just (Program (Diff (Const 2) (Diff (Const 4) (Const 3)))) )
                , ( """
                    -(
                        -(5 , 3),
                        -(0 , 1)
                    )
                    """
                  , Just (Program (Diff (Diff (Const 5) (Const 3)) (Diff (Const 0) (Const 1))))
                  )
                ]
        ]
