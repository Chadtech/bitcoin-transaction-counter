module Main.Update exposing (update)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Transaction as Transaction
import Main.WebSocket as WebSocket
import Time
import Task


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        HearWebSocket str ->
            WebSocket.hear model str

        Ping ->
            ( model, WebSocket.ping )

        CountOneSecond now ->
            case model.startUpTime of
                Just startUpTime ->
                    { model
                        | currentTime = Just now
                    }
                        ! []

                Nothing ->
                    model ! [ Task.perform GetInitTime Time.now ]

        GetInitTime time ->
            { model
                | startUpTime = Just time
                , currentTime = Just time
            }
                ! []

        GetWindowSize size ->
            { model
                | windowSize = Just size
            }
                ! []
