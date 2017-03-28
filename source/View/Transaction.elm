module View.Transaction exposing (view)

import Html exposing (Html)
import Types.Model exposing (Model)
import Types.Message exposing (Message)
import Types.Transaction exposing (Transaction)
import Time exposing (Time)
import Date exposing (Date)
import View.Basics exposing (words, transaction)
import Util.ParseNumber as Util


view : Model -> Int -> Transaction -> Html Message
view { transactions, currentTime } index t =
    let
        container =
            if index % 2 == 0 then
                transaction ""
            else
                transaction "odd"

        ( btc, usd, degree ) =
            values (toFloat t.satoshis / 100000000)

        timeSince =
            case currentTime of
                Nothing ->
                    "XX:XX"

                Just time ->
                    t.time
                        |> (*) 1000
                        |> Date.fromTime
                        |> formatTime
    in
        container
            [ words "time" timeSince
            , words ("btc " ++ degree) btc
            , words ("usd " ++ degree) usd
            ]


formatTime : Date -> String
formatTime date =
    let
        hour =
            Date.hour date |> toString

        minute =
            let
                m =
                    Date.minute date
            in
                if m < 10 then
                    "0" ++ (toString m)
                else
                    toString m
    in
        hour ++ ":" ++ minute


values : Float -> ( String, String, String )
values btc =
    let
        class =
            if btc > 1 then
                if btc > 10 then
                    "red"
                else
                    "yellow"
            else
                ""
    in
        ( Util.parse btc
        , "~$" ++ (Util.parse (btc * 1023.56))
        , class
        )
