module Main.Init exposing (model, cmd)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Main.WebSocket exposing (url)
import WebSocket
import Time
import Task
import Window


model : Model
model =
    { startUpTime = Nothing
    , currentTime = Nothing
    , transactions = []
    , windowSize = Nothing
    }


cmd : Cmd Message
cmd =
    Cmd.batch
        [ WebSocket.send url "{\"op\" : \"unconfirmed_sub\"}"
        , Task.perform GetInitTime Time.now
        , Task.perform GetWindowSize Window.size
        ]
