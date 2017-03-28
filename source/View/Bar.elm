module View.Bar exposing (view)

import Html exposing (Html)
import Types.Message exposing (Message(..))
import View.Basics exposing (bar)
import Window exposing (Size)


view : Int -> Size -> Int -> Html Message
view max size value =
    let
        height =
            (toFloat value) / (toFloat max)

        axisHeight =
            (size.height // 2) - 32
    in
        bar height (toFloat axisHeight)
