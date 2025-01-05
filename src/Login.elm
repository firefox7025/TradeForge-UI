module Login exposing (loginPage)

import Components.Util exposing (Msg(..))
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)


type alias Model =
    { username : String
    , password : String
    , token : String
    , errorMsg : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" "" "" "", Cmd.none )


api : String
api =
    "https://api.tradeforge.ultimaengineering.io"


registerUrl : String
registerUrl =
    api ++ "/users/login"


authRequestBody : Model -> Encode.Value
authRequestBody model =
    Encode.object
        [ ( "username_or_email", Encode.string model.username )
        , ( "password", Encode.string model.password )
        ]


authUserCmd : Model -> String -> Cmd Msg
authUserCmd model apiUrl =
    Http.post
        { url = apiUrl
        , body = Http.jsonBody (authRequestBody model)
        , expect = Http.expectJson GetTokenCompleted authResponseDecoder
        }


getTokenCompleted : Model -> Result Http.Error String -> ( Model, Cmd Msg )
getTokenCompleted model result =
    case result of
        Ok newToken ->
            ( { model | token = newToken, password = "", errorMsg = "" } |> Debug.log "Token acquired", Cmd.none )

        Err error ->
            ( { model | errorMsg = Debug.toString error }, Cmd.none )


authResponseDecoder : Decoder String
authResponseDecoder =
    Decode.field "sub" Decode.string


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername username ->
            ( { model | username = username } |> Debug.log "Username Updated", Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        ClickRegisterUser ->
            ( model, authUserCmd model registerUrl )

        GetTokenCompleted result ->
            getTokenCompleted model result

        NoOp ->
            ( model, Cmd.none )


loginPage : Element Msg
loginPage =
    column
        [ width fill, padding 60 ]
        [ el [] (text "Log In or Register")
        , el []
            (text "If you already have an account, please Log In below. Otherwise, please see the registration page.")
        , el [ centerY, padding 10 ]
            (column []
                [ el [] (text "Username:")
                , el []
                    (Input.username
                        [ Border.width 1, Border.color (rgb255 200 200 200), padding 10 ]
                        { label = Input.labelHidden "Username"
                        , onChange = SetUsername
                        , placeholder = Nothing
                        , text = ""
                        }
                    )
                , el [] (text "Password:")
                , el []
                    (Input.currentPassword
                        [ Border.width 1, Border.color (rgb255 200 200 200), padding 10 ]
                        { label = Input.labelHidden "Password"
                        , text = ""
                        , onChange = SetPassword
                        , placeholder = Nothing
                        , show = False
                        }
                    )
                ]
            )
        ]
