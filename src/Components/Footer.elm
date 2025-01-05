module Components.Footer exposing (footer)

import Components.Util exposing (Msg(..))
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font


navLink : String -> String -> Element Msg
navLink label url =
    text label
        |> el
            [ Font.color (rgb255 255 255 255)
            , Border.rounded 5
            , Background.color (rgb255 51 51 51)
            , paddingXY 10 5
            , mouseOver [ Background.color (rgb255 87 87 87) ]
            ]


footer : Element Msg
footer =
    row []
        [ navLink "Profile" ""
        ]
