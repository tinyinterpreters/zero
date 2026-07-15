module Test.DIFF.Interpreter exposing (suite)

import DIFF.Interpreter as I exposing (Value(..))
import Test exposing (Test, describe)
import Test.Lib exposing (testValue)


suite : Test
suite =
    describe "DIFF.Interpreter"
        [ describe "run" <|
            List.map (testValue I.run)
                -- Constant expressions
                [ ( "123", Just (VNumber 123) )
                , ( "123 ", Just (VNumber 123) )
                , ( "123  ", Just (VNumber 123) )
                , ( " 123", Just (VNumber 123) )
                , ( "  123", Just (VNumber 123) )
                , ( "123abc", Nothing )
                , ( "onetwothree", Nothing )

                -- Difference expressions
                , ( "-(456,123)", Just (VNumber 333) )
                , ( "-(456, 123)", Just (VNumber 333) )
                , ( "- ( 2, -( 4, 3 ) )", Just (VNumber 1) )
                , ( """
                    -(
                        -(5 , 3),
                        -(0 , 1)
                    )
                    """
                  , Just (VNumber 3)
                  )
                ]
        ]
