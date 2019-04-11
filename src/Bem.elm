module Bem exposing
    ( modList, mod, modifier
    , el, element
    , block
    )

{-| This package has a set of utilities for using the [BEM](http://getbem.com/naming/)
convention in Elm. Exposing the functions in this module is disencouraged: the functions
were intentionally given small and vague names to avoid verboseness.

    view : { stickyHeader : Bool } -> Html msg
    view model =
        header
            [ Bem.mod "nav" ( "sticky", model.stickyHeader ) ]
            [ h1 [] [ text "header" ]

            -- ...
            ]


# Modifiers

@docs modList, mod, modifier


# Elements

@docs el, element


# Blocks

@docs block

-}

import Html exposing (Attribute)
import Html.Attributes exposing (class)
import List
import String


{-| Like [classList](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#classList)
but for [BEM](http://getbem.com/naming/) modifiers.

    button
        [ modList "button"
            [ ( "primary", True )
            , ( "small", False )
            ]
        ]
        [ text "click me" ]

-}
modList : String -> List ( String, Bool ) -> Attribute msg
modList base =
    class
        << String.join " "
        << (::) base
        << List.map (Tuple.first >> modifier base)
        << List.filter Tuple.second


{-| Shorthand version of `modList` supporting one modifier.

    button
        [ mod "button" ( "primary", True ) ]
        [ text "click me" ]

-}
mod : String -> ( String, Bool ) -> Attribute msg
mod base ( name, active ) =
    class <|
        if active then
            base ++ " " ++ modifier base name

        else
            ""


{-| Returns a _element_ class

    button [ mod "button" ( "primary", True ) ]
        [ span [ el "button" "label" ] [ text "click me" ]
        , i [ el "button" "icon" ] []
        ]

-}
el : String -> String -> Attribute msg
el base name =
    class <| element base name


{-| Returns a record with the partially-applied versions of `el`, `mod` and `modList`
using the base class supplied.

    checkbox =
        Bem.block "checkbox"

    view =
        div [ checkbox.mod "big" ]
            [ input [ checkbox.el "input" ] []
            , i [ checkbox.el "tick" ] []
            ]

-}
block :
    String
    ->
        { el : String -> Attribute msg
        , mod : ( String, Bool ) -> Attribute msg
        , modList : List ( String, Bool ) -> Attribute msg
        }
block base =
    { el = el base, mod = mod base, modList = modList base }


{-| Joins two strings using the _element_ separator.

    element "form" "section" == "form__section"

    element "switch" "handle" == "switch__handle"

-}
element : String -> String -> String
element base name =
    base ++ "__" ++ name


{-| Joins two strings using the _modifier_ separator.

    modifier "form" "invalid" == "form--invalid"

    modifier "switch" "on" == "switch--on"

-}
modifier : String -> String -> String
modifier base name =
    base ++ "--" ++ name
