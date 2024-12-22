module Components.HomePage exposing (homePage)

import Element exposing (Element, column, text, centerX, centerY)

homePage : Element msg
homePage =
    column
        [ centerX, centerY ]
        [ text "Welcome to the Home Page!" ]
