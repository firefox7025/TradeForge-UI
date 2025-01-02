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
import Components.Footer as Footer

-- MAIN

main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model =
    { token : String
    , errorMsg : String
    , username : String
    , password : String
    }

init : Model
init =
    { token = ""
    , errorMsg = ""
    , username = ""
    , password = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


-- VIEW

view : Model -> Html Msg
view model =
    let
        loggedIn =
            String.length model.token > 0

        showError =
            if String.isEmpty model.errorMsg then
                "hidden"
            else
                ""
    in
    if loggedIn then
        Element.layout []
            (column []
                [ NavBar.navBar
                , mainContent
                , Footer.footer
                ]
            )
    else
        Element.layout []
            (column []
                [ loginPage ]
            )

mainContent : Element Msg
mainContent =
    column
        [
          width fill,
          padding 60,
          height fill
        ]
        [ text "Total Account Balance and Returns"
            |> el [  ]
        , text "Chart with investments total Returns"
            |> el [ ]
        , text "Ticker showing Buying power, Cash, Daily Change, and Number of Trades Made Today"
            |> el [ ]
        , text "Top Returning Positions"
            |> el [ ]
        ]
