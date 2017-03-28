module Main.Subscriptions exposing (subscriptions)

import Types.Message exposing (Message(..))
import Types.Model exposing (Model)
import WebSocket
import Main.WebSocket exposing (url)
import Time exposing (Time)
import Window


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ WebSocket.listen url HearWebSocket
        , Time.every 30000 (always Ping)
        , Time.every 1000 CountOneSecond
        , Window.resizes GetWindowSize
        ]
