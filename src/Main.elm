module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events 
import Element.Font as Font
import Components.NavBar as NavBar
import Components.Util exposing (Msg(..))

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
        [NavBar.navBar, mainContent
        ]
    )

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
