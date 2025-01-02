import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)

type alias Model =
    {  username: String
     , password: String
     , token : String
     , errorMsg : String
    }

init : (Model, Cmd Msg)
init =
    ( Model "" "" "" "", userLogin )


registerUrl : String
registerUrl = api ++ "/users/login"

userEncoder : Model -> Encode.Value
userEncoder model =
    Encode.object
        [
         ("username_or_email", Encode.string.model.username)
        ,("password", Encode.string model.password)
        ]

authUser : Model -> String -> Http.Request String
authUser model apiUrl =
    let
        body =
            model
                |> userEncoder
                |> jsonBody
    in
        Http.post apiUrl body tokenDecoder

authUserCmd : Model -> String -> Cmd Msg
authUserCmd model apiUrl
    Http.send GetTokenCompleted (authUser model apiUrl)

getTokenCompleted : Model -> Result Http.Error String -> ( Model, Cmd Msg )
getTokenCompleted model result =
    case result of
        Ok newToken ->
            ( { model | token = newtoken, password = "", errorMsg = ""} |> Debug.log "Token aquired", Cmd.none )
        Err error ->
            ( { model | errorMsg = (toString error) }, Cmd.none )

tokenDecoder : Decoder String
tokenDecoder =
    Decode.field "sub" Decode.string



type Msg
    ...
    | SetUsername String
    | SetPassword String
    | ClickRegisterUser
    | GetTokenCompleted (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ...

            SetUsername username ->
                ( { model | username = username }, Cmd.none )

            SetPassword password ->
                ( { model | password = password }, Cmd.none )

            ClickRegisterUser ->
                (model, authUserCmd model registerUrl )

            GetTokenCompleted result ->
                getTokenCompleted model result

loginPage : Element Msg
loginPage =
    column
        [ width fill, padding 60 ]
        [ el [] (text "Log In or Register")
        , el []
            (text "If you already have an account, please Log In. Otherwise, enter your desired username and password and Register.")
        , el [ centerY, padding 10 ]
            (column []
                [ el [] (text "Username:")
                , el []
                    (Input.text
                        [ Border.width 1, Border.color (rgb255 200 200 200), padding 10 ]
                        { value = "", onInput = SetUsername, placeholder = Just "Enter your username" }
                    )
                , el [] (text "Password:")
                , el []
                    (Input.password
                        [ Border.width 1, Border.color (rgb255 200 200 200), padding 10 ]
                        { value = "", onInput = SetPassword, placeholder = Just "Enter your password" }
                    )
                , el [ centerX, padding 20 ]
                    (Button.button
                        [ Background.color (rgb255 0 123 255), Font.color white, padding 15, Border.rounded 5 ]
                        { onPress = ClickRegisterUser }
                        (text "Register")
                    )
                ]
            )
        ]
