module Components.NavBar exposing (navBar)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events 
import Element.Font as Font
import Components.Util exposing (Msg(..))

navBar : Element Msg
navBar =
    row
        [ spacing 20
        , padding 10
        , Background.color (rgb255 51 51 51)
        ]
        [ navLink "Home" "#"
        , navLink "Account" "#account"
        , navLink "TradeForge Connect" "#connect"
        , navLink "Plans and Features" "#plans"
        , navLink "Funds and Wallets" "#funds"
        , navLink "Support" "#support"
        ]


navLink : String -> String -> Element Msg
navLink label url =
    text label
        |> el
            [ Font.color (rgb255 255 255 255) 
            , Border.rounded 5
            , paddingXY 10 5
            , mouseOver [ Background.color (rgb255 87 87 87) ]
            ]
