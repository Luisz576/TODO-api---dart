import 'package:hive/hive.dart';
import 'package:todo_api/models/todo.dart';

class TodoAdapter extends TypeAdapter<Todo>{
  @override
  Todo read(BinaryReader reader) {
    return Todo(reader.readInt(), reader.readString(), reader.readBool());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeBool(obj.done);
  }
}