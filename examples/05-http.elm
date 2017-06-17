module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = init "cats"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { currentTopic : String
    , nextTopic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init currentTopic =
    ( Model currentTopic "" "/images/waiting.gif"
    , getRandomGif currentTopic
    )



-- UPDATE


type Msg
    = MorePlease
    | NextTopic String
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( Model model.nextTopic "" model.gifUrl, getRandomGif model.nextTopic )

        NextTopic nextTopic ->
            ( Model model.currentTopic nextTopic model.gifUrl, Cmd.none )

        NewGif (Ok newUrl) ->
            ( Model model.currentTopic model.nextTopic newUrl, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.currentTopic ]
        , input [ type_ "text", placeholder "topic", onInput NextTopic, value model.nextTopic ] []
        , button [ onClick MorePlease ] [ text "More Please!" ]
        , br [] []
        , img [ src model.gifUrl ] []
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif currentTopic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ currentTopic
    in
        Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
