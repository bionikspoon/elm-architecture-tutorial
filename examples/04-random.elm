module Main exposing (..)

import Html exposing (..)
import Html.Attributes
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { dieFace1 : Int
    , dieFace2 : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1 1, Cmd.none )



-- UPDATE


type Msg
    = Roll
    | NewFace1 Int
    | NewFace2 Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace1 (Random.int 1 6) )

        NewFace1 newFace ->
            ( { model | dieFace1 = newFace }, Random.generate NewFace2 (Random.int 1 6) )

        NewFace2 newFace ->
            ( { model | dieFace2 = newFace }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ dieFace model.dieFace1
        , dieFace model.dieFace2
        , button [ onClick Roll, Html.Attributes.style [ ( "display", "block" ) ] ] [ Html.text "Roll" ]
        ]


dieFace : Int -> Svg Msg
dieFace number =
    svg [ width "200", height "200" ]
        (dieFaceContainer :: dieFaceSide number)


dieFaceContainer : Svg Msg
dieFaceContainer =
    rect [ x "3", y "3", rx "25", ry "25", width "194", height "194", fill "white", stroke "black", strokeWidth "6" ] []


dieFaceSide : Int -> List (Svg Msg)
dieFaceSide number =
    case number of
        6 ->
            [ circle [ cx "45", cy "45", r "25", fill "black" ] []
            , circle [ cx "45", cy "97", r "25", fill "black" ] []
            , circle [ cx "45", cy "148", r "25", fill "black" ] []
            , circle [ cx "148", cy "45", r "25", fill "black" ] []
            , circle [ cx "148", cy "97", r "25", fill "black" ] []
            , circle [ cx "148", cy "148", r "25", fill "black" ] []
            ]

        5 ->
            [ circle [ cx "45", cy "45", r "25", fill "black" ] []
            , circle [ cx "45", cy "148", r "25", fill "black" ] []
            , circle [ cx "97", cy "97", r "25", fill "black" ] []
            , circle [ cx "148", cy "148", r "25", fill "black" ] []
            , circle [ cx "148", cy "45", r "25", fill "black" ] []
            ]

        4 ->
            [ circle [ cx "45", cy "45", r "25", fill "black" ] []
            , circle [ cx "45", cy "148", r "25", fill "black" ] []
            , circle [ cx "148", cy "148", r "25", fill "black" ] []
            , circle [ cx "148", cy "45", r "25", fill "black" ] []
            ]

        3 ->
            [ circle [ cx "45", cy "148", r "25", fill "black" ] []
            , circle [ cx "97", cy "97", r "25", fill "black" ] []
            , circle [ cx "148", cy "45", r "25", fill "black" ] []
            ]

        2 ->
            [ circle [ cx "45", cy "148", r "25", fill "black" ] []
            , circle [ cx "148", cy "45", r "25", fill "black" ] []
            ]

        _ ->
            [ circle [ cx "97", cy "97", r "25", fill "black" ] [] ]
