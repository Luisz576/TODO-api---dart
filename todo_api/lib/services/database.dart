import 'package:hive/hive.dart';
import 'package:todo_api/models/todo.dart';

class Database{
  static final Database instance = Database._();

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

  Future<bool> createTodo(String title) async{
    if(_setuped){
      try{
        await _hiveDb.add(Todo(DateTime.now().millisecondsSinceEpoch, title, false));
        return true;
      }catch(_){
        return false;
      }
    }
    return false;
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
      //TODO:
      return true;
    }
    return false;
  }

  Future<bool> deleteTodo(int todoId) async{
    if(_setuped){
      return true;
    }
    return false;
  }
}