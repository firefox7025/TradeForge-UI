module Components.NavBar exposing (navBar)

import Element exposing (Element, column, row, text, onClick, backgroundColor, padding, borderRadius)

type Msg = NavigateToHome | NavigateToAbout

navBar : (Msg -> msg) -> (Msg -> msg) -> Element msg
navBar onHomeClick onAboutClick =
    column
        [ width 1000, backgroundColor (Element.rgb 33 33 33), padding 20 ]
        [ row [ spacing 10 ]
            [ button [ onClick (onHomeClick NavigateToHome), padding 10, backgroundColor (Element.rgb 0 188 212), borderRadius 4 ] [ text "Home" ]
            , button [ onClick (onAboutClick NavigateToAbout), padding 10, backgroundColor (Element.rgb 0 188 212), borderRadius 4 ] [ text "About" ]
            ]
        ]
