module Main exposing (Model, Msg(..), init, update, view)

import Chart as C
import Chart.Attributes as CA
import Chart.Events as CE
import Chart.Item as CI
import Chart.Svg as S
import Html as H


type alias Model =
    { hovering : List (CI.Many Datum CI.Dot) }


init : Model
init =
    { hovering = [] }


type Msg
    = OnHover (List (CI.Many Datum CI.Dot))


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnHover hovering ->
            { model | hovering = hovering }


view : Model -> H.Html Msg
view model =
    C.chart
        [ CA.height 300
        , CA.width 300
        , CA.padding { top = 0, bottom = 0, left = 10, right = 10 }
        , CI.dots
            |> CI.andThen CI.stacks
            |> CE.getNearest
            |> CE.onMouseMove OnHover
        , CE.onMouseLeave (OnHover [])
        ]
        [ C.xLabels [ CA.withGrid ]
        , C.yLabels [ CA.withGrid, CA.pinned .min ]
        , C.series .x
            [ C.stacked
                [ C.interpolated .p [] [ CA.circle ]
                , C.interpolated .q [] [ CA.circle ]
                ]
            ]
            data
        , C.bars [ CA.x1 .x1, CA.x2 .x2 ]
            [ C.bar .z [ CA.color CA.purple ]
            ]
            data
        , C.each model.hovering <|
            \p item ->
                [ C.tooltip item [] [] [] ]
        ]
