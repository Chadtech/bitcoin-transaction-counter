module View.ValueGraph exposing (view)

import Html exposing (Html)
import Types.Model exposing (Model)
import Types.Message exposing (Message)
import Types.Transaction exposing (Transaction)
import Util.Transactions as Util
import Util.ParseNumber as Number
import View.Basics exposing (card, words)
import View.Bar as Bar


view : Model -> List ( Int, List Transaction ) -> Html Message
view model sortedTransactions =
    let
        values =
            List.map toValue sortedTransactions
    in
        case ( List.maximum values, model.windowSize ) of
            ( Just max, Just size ) ->
                values
                    |> List.map (Bar.view max size)
                    |> List.append
                        [ yAxisLevel max
                        , yAxisLabel
                        , xAxisLabel
                        ]
                    |> card "value-graph"

            _ ->
                card "value-graph" []


yAxisLevel : Int -> Html Message
yAxisLevel satoshis =
    (Number.parse (toFloat satoshis / 100000000))
        ++ " BTC"
        |> (++) "y-axis = "
        |> words "y-axis-level"


yAxisLabel : Html Message
yAxisLabel =
    words "y-axis" "BTC"


xAxisLabel : Html Message
xAxisLabel =
    words "x-axis" "Minutes"


toValue : ( Int, List Transaction ) -> Int
toValue ( _, transactions ) =
    List.foldr (.satoshis >> (+)) 0 transactions
