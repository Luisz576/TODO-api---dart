# TODO-api---dart
This is a simple TODO list API.

This project was created using dart.

## Api
<strong>Definitions</strong>
  When you read \<API\> it means:

  *\<API\> = \<API_URL\>:\<API_PORT\>*

  And \<TOKEN\> means that is a valid token. In the token logic was used only a regex expresion to verify if the passed token value is valid. (You can change it on 'Auth.dart')

  Regex: "(l[a-z]5[0-9]7[A-Z]6[567][aAlLbB]l[0-9]5[AWSD]7[A-Z]6[a-z]=)"

<strong>Actions</strong>
  - <strong>(GET) get todo</strong>

    \<API\>/todo/\<todo_id\>/\<TOKEN\>

  - <strong>(GET) get all todos</strong>

    \<API\>/todos/\<TOKEN\>

  - <strong>(POST) create a todo</strong>

    \<API\>/todo/\<TOKEN\>

    - body json:

        <code>{
            "title": <TODO_TITLE>
        }</code>

  - <strong>(PATCH) make a todo done</strong>

    \<API\>/done/\<todo_id\>/\<TOKEN\>

  - <strong>(DELETE) delete a todo</strong>

    \<API\>/todo/\<todo_id\>/\<TOKEN\>

## Packages
Was used these packages:

- shelf: ^1.4.0
- shelf_router: ^1.1.3
- hive: ^2.2.3
- path: ^1.8.3