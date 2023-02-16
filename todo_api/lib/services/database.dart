import 'package:hive/hive.dart';
import 'package:todo_api/errors/database_not_initialized_exception.dart';
import 'package:todo_api/models/adapters/todo_adapter.dart';
import 'package:todo_api/models/todo.dart';
import 'package:path/path.dart' as path;

class Database{
  static Database? _instance;
  static Database get instance{
    if(_instance == null){
      throw DatabaseNotInitializedException();
    }
    return _instance!;
  }

  static initialize(){
    if(_instance == null){
      Hive.init(path.current);
      Hive.registerAdapter(TodoAdapter());
      _instance = Database._();
    }
  }

  bool _setuped = false;
  bool get setuped => _setuped;

  late final Box<Todo> _hiveDb;
  Database._(){
    Hive.openBox<Todo>('todos').then((box){
      _hiveDb = box;
      _setuped = true;
    });
  }

  Future<List<Todo>> getTodos() async{
    if(_setuped){
      return List.unmodifiable(_hiveDb.values);
    }
    return [];
  }

  Future<Todo?> getTodo(int todoId) async{
    List<Todo> todos = await getTodos();
    Todo? todo;
    for(Todo t in todos){
      if(t.id == todoId){
        todo = t;
        break;
      }
    }
    return todo;
  }

  Future<Todo?> createTodo(String title) async{
    if(_setuped){
      try{
        Todo todo = Todo(DateTime.now().millisecondsSinceEpoch, title, false);
        await _hiveDb.add(todo);
        return todo;
      }catch(_){
        print(_);
        return null;
      }
    }
    return null;
  }

  Future<bool> makeDone(int todoId) async{
    if(_setuped){
      List<Todo> todos = await getTodos();
      Todo? todo;
      int index = -1;
      for(int i = 0; i < todos.length; i++){
        if(todos[i].id == todoId){
          todo = todos[i];
          index = i;
          break;
        }
      }
      if(index == -1 || todo == null){
        return false;
      }
      todo.done = true;
      await _hiveDb.putAt(index, todo);
      return true;
    }
    return false;
  }

  Future<bool> deleteTodo(int todoId) async{
    if(_setuped){
      int index = -1;
      List<Todo> todos = await getTodos();
      for(int i = 0; i < todos.length; i++){
        if(todos[i].id == todoId){
          index = i;
          break;
        }
      }
      if(index == -1){
        return false;
      }
      await _hiveDb.deleteAt(index);
      return true;
    }
    return false;
  }
}