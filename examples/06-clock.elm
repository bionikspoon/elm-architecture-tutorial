module Main exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        minuteAngle =
            turns (Time.inMinutes model)

        minuteHandX =
            toString (50 + 40 * cos minuteAngle)

        minuteHandY =
            toString (50 + 40 * sin minuteAngle)

        hourAngle =
            turns (Time.inHours model)

        hourHandX =
            toString (50 + 20 * cos hourAngle)

        hourHandY =
            toString (50 + 20 * sin hourAngle)

        secondAngle =
            turns (Time.inSeconds model)

        secondHandX =
            toString (50 + 40 * cos secondAngle)

        secondHandY =
            toString (50 + 40 * sin secondAngle)
    in
        svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", y1 "50", x2 minuteHandX, y2 minuteHandY, stroke "#023963" ] []
            , line [ x1 "50", y1 "50", x2 hourHandX, y2 hourHandY, stroke "#023963" ] []
            , line [ x1 "50", y1 "50", x2 secondHandX, y2 secondHandY, stroke "red" ] []
            ]
