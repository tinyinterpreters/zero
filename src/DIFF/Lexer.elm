module DIFF.Lexer exposing (digits, spaces, symbol)

import Parser as P exposing ((|.), (|=), Parser)


digits : Parser Int
digits =
    chompOneOrMore Char.isDigit
        |> P.getChompedString
        |> P.map (Maybe.withDefault 0 << String.toInt)
        |> lexeme


chompOneOrMore : (Char -> Bool) -> Parser ()
chompOneOrMore isGood =
    P.succeed ()
        |. P.chompIf isGood
        |. P.chompWhile isGood


symbol : String -> Parser ()
symbol =
    lexeme << P.symbol


lexeme : Parser a -> Parser a
lexeme p =
    P.succeed identity
        |= p
        |. spaces


spaces : Parser ()
spaces =
    P.spaces
