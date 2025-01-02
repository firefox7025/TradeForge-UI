module Components.Footer exposing (footer)
import Element exposing (..)


footer : Element Msg
footer =
    row
        [ spacing 20
        , padding 10
        , Background.color (rgb255 255 255 255)
        ]
        [ navLink "Home" "#"
        , navLink "About" "#about"
        , navLink
              "Contact" "#contact"
        ]import Element exposing (..)
