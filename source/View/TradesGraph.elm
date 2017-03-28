module View.TradesGraph exposing (view)

import Html exposing (Html)
import View.Basics exposing (card, words)
import View.Bar as Bar
import Types.Model exposing (Model)
import Types.Message exposing (Message)
import Types.Transaction exposing (Transaction)
import Util.ParseNumber as Number


view : Model -> List ( Int, List Transaction ) -> Html Message
view model sortedTransactions =
    let
        tradeCounts =
            List.map
                (Tuple.second >> List.length)
                sortedTransactions
    in
        case ( List.maximum tradeCounts, model.windowSize ) of
            ( Just max, Just size ) ->
                tradeCounts
                    |> List.map (Bar.view max size)
                    |> List.append
                        [ yAxisLevel max
                        , yAxisLabel
                        , xAxisLabel
                        ]
                    |> card "trades-graph"

            _ ->
                card "trades-graph" []


yAxisLevel : Int -> Html Message
yAxisLevel trades =
    (Number.parse (toFloat trades))
        ++ " trades"
        |> (++) "y-axis = "
        |> words "y-axis-level"


yAxisLabel : Html Message
yAxisLabel =
    words "y-axis trades" "trades"


xAxisLabel : Html Message
xAxisLabel =
    words "x-axis" "Minutes"
