module Tests exposing (suite)

import Bem
import Expect
import Html.Attributes as Attrs
import Test exposing (..)


suite : Test
suite =
    describe "Bem"
        [ test "Joins strings with an Element separator " <|
            \() ->
                Expect.equal (Bem.element "button" "label") "button__label"
        , test "Joins strings with a Modifier separator" <|
            \() ->
                Expect.equal (Bem.modifier "button" "ghost") "button--ghost"
        , test "Creates a modified class" <|
            \() ->
                Expect.equal
                    (Bem.mod "button" ( "ghost", True ))
                    (Attrs.class "button button--ghost")
        , test "Creates an Element class" <|
            \() ->
                Expect.equal
                    (Bem.el "button" "label")
                    (Attrs.class "button__label")
        , test "Filters disabled modifiers and concats the rest" <|
            \() ->
                Expect.equal
                    (Bem.modList "button" [ ( "disabled", True ), ( "primary", False ) ])
                    (Attrs.class "button button--disabled")
        ]
