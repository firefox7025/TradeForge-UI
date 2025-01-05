module Components.Util exposing (Msg(..))

import Http


type Msg
    = SetUsername String
    | SetPassword String
    | ClickRegisterUser
    | GetTokenCompleted (Result Http.Error String)
    | NoOp
