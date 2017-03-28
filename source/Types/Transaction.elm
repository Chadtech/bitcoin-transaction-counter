module Types.Transaction exposing (Transaction, decode)

import Time exposing (Time)
import Json.Decode exposing (Decoder)
import Json.Decode as Json
import Json.Decode.Pipeline as Pipeline


type alias Transaction =
    { time : Time
    , location : String
    , satoshis : Int
    }


type alias TransactionJson =
    { time : Time
    , location : String
    , outs : List Int
    }


decode : String -> Maybe Transaction
decode json =
    case Json.decodeString decoder json of
        Ok val ->
            Just
                { time = val.time
                , location = val.location
                , satoshis = List.sum val.outs
                }

        Err err ->
            Nothing


decoder : Decoder TransactionJson
decoder =
    Json.map3 TransactionJson
        (Json.at [ "x", "time" ] Json.float)
        (Json.at [ "x", "relayed_by" ] Json.string)
        (Json.at [ "x", "out" ] (Json.list (Json.at [ "value" ] Json.int)))
