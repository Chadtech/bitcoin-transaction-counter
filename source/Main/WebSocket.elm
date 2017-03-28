module Main.WebSocket exposing (url, ping, decode, hear)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Types.Transaction as Transaction
import WebSocket
import Json.Decode as Json
import Debug exposing (log)


url : String
url =
    "wss://ws.blockchain.info/inv"


ping : Cmd Message
ping =
    WebSocket.send url "{\"op\":\"ping\"}"


hear : Model -> String -> ( Model, Cmd Message )
hear model json =
    case ( decode json, Transaction.decode json ) of
        ( Just "utx", Just transaction ) ->
            { model
                | transactions =
                    transaction :: model.transactions
            }
                ! []

        _ ->
            ( model, Cmd.none )


decode : String -> Maybe String
decode json =
    Json.decodeString
        (Json.at [ "op" ] Json.string)
        json
        |> Result.toMaybe
