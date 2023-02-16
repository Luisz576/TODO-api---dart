import 'package:hive/hive.dart';
import 'package:todo_api/interfaces/ijson.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject with IJson {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool done;

  Todo(this.id, this.title, this.done);
  
  @override
  Map<dynamic, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "done": done
    };
  }
}