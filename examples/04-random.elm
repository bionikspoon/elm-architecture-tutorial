module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random


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
        [ div [ containerStyle ]
            [ div [ dieFaceSpriteStyle model.dieFace1 ] []
            , div [ dieFaceSpriteStyle model.dieFace2 ] []
            ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]


imgOffset : Int -> String
imgOffset number =
    case number of
        1 ->
            "-11px"

        2 ->
            "-127px"

        3 ->
            "-242px"

        4 ->
            "-358px"

        5 ->
            "-473px"

        6 ->
            "-589px"

        _ ->
            "-11px"


containerStyle : Attribute msg
containerStyle =
    style
        [ ( "display", "flex" )
        ]


dieFaceSpriteStyle : Int -> Attribute msg
dieFaceSpriteStyle number =
    style
        [ ( "backgroundImage", "url(/images/die-faces.png)" )
        , ( "backgroundPositionX", imgOffset number )
        , ( "backgroundPositionY", "115px" )
        , ( "height", "110px" )
        , ( "width", "110px" )
        ]
