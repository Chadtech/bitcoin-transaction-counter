module View.Transactions exposing (view)

import Html exposing (Html)
import Types.Message exposing (Message(..))
import Types.Model exposing (Model)
import Types.Transaction exposing (Transaction)
import View.Basics exposing (words, card, transaction)
import View.Transaction as Transaction
import Date
import Time exposing (Time)


view : Model -> Html Message
view =
    body >> List.append [ columns ] >> card "transactions"


body : Model -> List (Html Message)
body model =
    if List.isEmpty model.transactions then
        [ words "" "loading transactions.." ]
    else
        List.indexedMap
            (Transaction.view model)
            (List.take 200 model.transactions)


columns : Html Message
columns =
    transaction "odd"
        [ words "time" "time"
        , words "btc" "BTC"
        , words "usd" "USD"
        ]
