module Types.Model exposing (Model)

import Time exposing (Time)
import Types.Transaction exposing (Transaction)
import Window exposing (Size)


type alias Model =
    { startUpTime : Maybe Time
    , currentTime : Maybe Time
    , transactions : List Transaction
    , windowSize : Maybe Size
    }
