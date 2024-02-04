import 'package:todo_provider/models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskDataSource {
  final _mybox = Hive.box('TasksBox');

  List<ToDo>? getAllTasks() {
    return List<ToDo>.from(_mybox.get('tasksList'));
  }

  void deleteAllTasks() {
    _mybox.clear();
  }

  void updateList(List<ToDo> todoList) {
    _mybox.put('tasksList', todoList);
  }
}
