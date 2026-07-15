module Test.Lib exposing (testValue)

import Expect
import Test exposing (Test, test)


testValue : (String -> Result e a) -> ( String, Maybe a ) -> Test
testValue f ( input, expectedOutput ) =
    test (Debug.toString input) <|
        \_ ->
            case f input of
                Ok value ->
                    if expectedOutput == Just value then
                        Expect.pass

                    else
                        Expect.fail <|
                            Debug.toString
                                { expected = expectedOutput
                                , actual = value
                                }

                Err e ->
                    if expectedOutput == Nothing then
                        Expect.pass

                    else
                        Expect.fail (Debug.toString e)
