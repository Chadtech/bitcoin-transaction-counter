module Util.ParseNumber exposing (parse)


parse : Float -> String
parse f =
    if 100 > f then
        String.slice 0 4 (toString f)
    else if 1000 > f then
        toString (floor f)
    else
        (String.slice 0 3 (toString (f / 1000))) ++ "K"
