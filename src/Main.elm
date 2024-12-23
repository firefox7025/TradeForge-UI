module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events 
import Element.Font as Font

-- MAIN

main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model =
    {}


init : Model
init =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


-- VIEW

view : Model -> Html Msg
view model =
    Element.layout []
        (column []
        [navBar, mainContent
        ]
    )


navBar : Element Msg
navBar =
    row
        [ spacing 20
        , padding 10
        , Background.color (rgb255 51 51 51)
        ]
        [ navLink "Home" "#"
        , navLink "About" "#about"
        , navLink
              "Contact" "#contact"
        ]


navLink : String -> String -> Element Msg
navLink label url =
    text label
        |> el
            [ Font.color (rgb255 255 255 255) 
            , Border.rounded 5
            , paddingXY 10 5
            , mouseOver [ Background.color (rgb255 87 87 87) ]
            , Events.onClick NoOp 
            ]


mainContent : Element Msg
mainContent =
    column
        [ padding 20
        , spacing 10
        ]
        [ text "Welcome to Your Elm-UI Page2!"
            |> el [  ]
        , text "This is your main content area."
            |> el [ ]
        ]
