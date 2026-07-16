module Test.ZERO.Interpreter exposing (suite)

import Test exposing (Test, describe)
import Test.Lib exposing (testValue)
import ZERO.Interpreter as I exposing (Value(..))


suite : Test
suite =
    describe "ZERO.Interpreter"
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
                , ( "-(zero?(0), 1)", Nothing )
                , ( "-(0, zero?(1))", Nothing )
                , ( "-(zero?(0), zero?(1))", Nothing )

                -- Is it zero?
                , ( "zero?(0)", Just (VBool True) )
                , ( "zero?( 0 ) ", Just (VBool True) )
                , ( """
                    zero?(
                        -( 0
                         , 1
                         )
                    )
                    """
                  , Just (VBool False)
                  )
                , ( "zero?(zero?(0))", Nothing )
                ]
        ]
