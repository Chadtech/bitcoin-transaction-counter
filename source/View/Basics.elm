module View.Basics exposing (..)

import Types.Message exposing (Message(..))
import Html exposing (Html, node, text)
import Html.Attributes exposing (class, style)


words : String -> String -> Html Message
words class_ str =
    node "words" [ class class_ ] [ text str ]


card : String -> List (Html Message) -> Html Message
card class_ children =
    node "card" [ class class_ ] children


transaction : String -> List (Html Message) -> Html Message
transaction class_ children =
    node "transaction" [ class class_ ] children


headerBar : List (Html Message) -> Html Message
headerBar children =
    node "header-bar" [] children


separator : Html Message
separator =
    node "separator" [] []


bar : Float -> Float -> Html Message
bar height max =
    let
        height_ =
            height * max

        margin =
            max - height_
    in
        node "bar"
            [ style
                [ ( "height", (toString height_) ++ "px" )
                , ( "margin-top", (toString margin) ++ "px" )
                ]
            ]
            []
