module Main exposing (..)

import String
import Char
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    }


model : Model
model =
    Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = age }



-- VIEW


view : Model -> Html Msg
view model =
    form [ onSubmit Submit ]
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
        , input [ type_ "number", placeholder "Age", onInput Age ] []
        , viewValidation model
        , button [] [ text "Submit" ]
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if String.length model.password < 8 then
                ( "red", "Password must be longer than 8." )
            else if not (contains model.password Char.isUpper) then
                ( "red", "Password must contain an uppercase character." )
            else if not (contains model.password Char.isLower) then
                ( "red", "Password must contain an lowercase character." )
            else if not (contains model.password Char.isDigit) then
                ( "red", "Password must contain a digit character." )
            else if not (model.password == model.passwordAgain) then
                ( "red", "Passwords do not match!" )
            else if not (isInt model.age) then
                ( "red", "Age must be number." )
            else
                ( "green", "OK" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]


contains : String -> (Char -> Bool) -> Bool
contains password fn =
    password
        |> String.filter fn
        |> String.length
        |> (<) 0


isInt : String -> Bool
isInt number =
    case String.toInt number of
        Err _ ->
            False

        Ok _ ->
            True
