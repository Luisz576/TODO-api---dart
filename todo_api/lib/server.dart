import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_api/models/todo.dart';
import 'package:todo_api/services/auth.dart';
import 'package:todo_api/services/database.dart';

runServer(String address, int port){
  final router = Router();

  router.get('/', (Request request){
    return Response(200, body: {
      "error": "Use a action"
    }.toString());
  });

  router.get('/todos/<token>', (Request request, String token) async{
    if(Auth.validateToken(token)){
      List<Todo> todos = await Database.instance.getTodos();
      
      final json = {
        "count": todos.length,
        "todos": todos.map((todo) => todo.toJson()).toList()
      }.toString();

      return Response(200, body: json);
    }
    return Response(403);
  });

  router.get('/todo/<todoId>/<token>', (Request request, String todoId, String token) async{
    if(Auth.validateToken(token)){
      final json = {};
      int id = -1;
      try{
        id = int.parse(todoId);
      }catch(_){
        json['error'] = "'todoId' is invalid!";
      }
      if(id != -1){
        Todo? todo = await Database.instance.getTodo(id);
        if(todo == null){
          json['error'] = "'todoId' not founded!";
          json['todo'] = "";
        }else{
          json['todo'] = todo.toJson();
        }
      }
      return Response(200, body: json.toString());
    }
    return Response(403);
  });

  router.post('/todo/<token>', (Request request, String token) async{
    if(Auth.validateToken(token)){
      final json = {};
      Map? req;
      try{
        req = jsonDecode(await request.readAsString());
      }catch(_){
        json['error'] = "Invalid body!";
      }
      if(req != null){
        try{
          String title = req['title'];
          json['result'] = await Database.instance.createTodo(title);
        }catch(_){
          json['error'] = "Invalid parameter(s)!";
        }
      }
      return Response(200, body: json.toString());
    }
    return Response(403);
  });

  router.patch('/done/<todoId>/<token>', (Request request, String todoId, String token) async{
    if(Auth.validateToken(token)){
      final json = {};
      int id = -1;
      try{
        id = int.parse(todoId);
      }catch(_){
        json['error'] = "Invalid todoId!";
      }
      if(id != -1){
        json['result'] = await Database.instance.makeDone(id);
      }
      return Response(200, body: json.toString());
    }
    return Response(403);
  });

  router.delete('/todo/<todoId>/<token>', (Request request, String todoId, String token) async{
    if(Auth.validateToken(token)){
      final json = {};
      int id = -1;
      try{
        id = int.parse(todoId);
      }catch(_){
        json['error'] = "Invalid todoId!";
      }
      if(id != -1){
        json['result'] = await Database.instance.deleteTodo(id);
      }
      return Response(200, body: json.toString());
    }
    return Response(403);
  });

  shelf_io.serve(router, address, port);
}