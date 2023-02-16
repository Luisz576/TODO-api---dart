import 'package:todo_api/server.dart';
import 'package:todo_api/services/database.dart';

void main(List<String> arguments){
  Database.initialize();
  runServer('0.0.0.0', 5760);
}