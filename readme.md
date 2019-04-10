# BEM in Elm

[BEM](http://getbem.com/naming/) utilities for Elm.

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
