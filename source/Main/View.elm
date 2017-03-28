module Main.View exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import View.Basics exposing (words, separator)
import View.Transactions as Transactions
import View.ValueGraph as ValueGraph
import View.TradesGraph as TradesGraph
import Util.Transactions as Util
import Util.ParseNumber as Number


view : Model -> Html Message
view model =
    let
        sortedTransactions =
            Util.sort model.transactions
    in
        div
            [ class "main" ]
            [ words "title" "Bitcoin Transaction Counter"
            , words "since-init" (transactionsCount model)
            , Transactions.view model
            , ValueGraph.view model sortedTransactions
            , TradesGraph.view model sortedTransactions
            ]


transactionsCount : Model -> String
transactionsCount { startUpTime, currentTime, transactions } =
    case ( startUpTime, currentTime ) of
        ( Just st, Just ct ) ->
            let
                count =
                    List.length transactions

                time =
                    Number.parse ((ct - st) / 60000)
            in
                (toString count) ++ " transactions in " ++ time ++ " minutes"

        _ ->
            ""
