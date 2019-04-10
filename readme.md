# [BEM](http://getbem.com/naming/) in Elm

This library contains utility functions for using the BEM convention in Elm avoiding verboseness and repetition. Browse the docs [here](https://package.elm-lang.org/packages/renanpvaz/elm-bem/latest/Bem).

```elm
import Bem

view : { stickyHeader : Bool } -> Html msg
view model =
    header
        [ Bem.mod "nav" ( "sticky", model.stickyHeader ) ]
        [ h1 [] [ text "header" ]
        -- ...
        ]
```

## Installing

Run the following command in the root of your project

```shell
$ elm package install renanpvaz/elm-bem
```

and import the library in a elm file like this

```elm
import Bem
```
