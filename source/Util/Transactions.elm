module Util.Transactions exposing (sort)

import Types.Transaction exposing (Transaction)
import Date exposing (Date, Month(..))
import Dict exposing (Dict)


sort : List Transaction -> List ( Int, List Transaction )
sort transactions =
    transactions
        |> List.map pairWithSortableDate
        |> List.foldr insert Dict.empty
        |> Dict.toList
        |> List.sortBy Tuple.first
        |> List.reverse


insert : ( Transaction, Int ) -> Dict Int (List Transaction) -> Dict Int (List Transaction)
insert ( transaction, date ) sortedTransactions =
    case Dict.get date sortedTransactions of
        Just ts ->
            Dict.insert date (transaction :: ts) sortedTransactions

        Nothing ->
            Dict.insert date [ transaction ] sortedTransactions


pairWithSortableDate : Transaction -> ( Transaction, Int )
pairWithSortableDate transaction =
    transaction.time
        |> (*) 1000
        |> Date.fromTime
        |> timeToSortableDate
        |> (,) transaction


timeToSortableDate : Date -> Int
timeToSortableDate date =
    let
        minute =
            Date.minute date

        hour =
            100 * Date.hour date

        month =
            100000 * getMonthAsInt date
    in
        minute + hour + month


getMonthAsInt : Date -> Int
getMonthAsInt date =
    case Date.month date of
        Jan ->
            0

        Feb ->
            1

        Mar ->
            2

        Apr ->
            3

        May ->
            4

        Jun ->
            5

        Jul ->
            6

        Aug ->
            7

        Sep ->
            8

        Oct ->
            9

        Nov ->
            10

        Dec ->
            11
