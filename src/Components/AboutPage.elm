module Components.AboutPage exposing (aboutPage)

import Element exposing (Element, column, text, centerX, centerY)

aboutPage : Element msg
aboutPage =
    column
        [ centerX, centerY ]
        [ text "This is the About Page!" ]
