module Types.Message exposing (Message(..))

import Time exposing (Time)
import Window exposing (Size)


type Message
    = HearWebSocket String
    | Ping
    | CountOneSecond Time
    | GetInitTime Time
    | GetWindowSize Size
