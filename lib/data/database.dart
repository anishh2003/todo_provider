import 'package:todo_provider/models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskDataSource {
  final _mybox = Hive.box('TasksBox');

  // void addTask(ToDo task, int index) {
  //   _mybox.put(index, task);
  // }

  // void updateTask(ToDo task, index) {
  //   _mybox.putAt(index, task);
  // }

  // void deleteTask(int index) {
  //   _mybox.deleteAt(index);
  // }

  List<ToDo>? getAllTasks() {
    // return _mybox.get('tasksList') as List<ToDo>?;
    return List<ToDo>.from(_mybox.get('tasksList'));
    //  final List<ToDo> todoList = _mybox.values.toList();
    // return  todoList;
  }

  void deleteAllTasks() {
    _mybox.clear();
  }

  void updateList(List<ToDo> todoList) {
    _mybox.put('tasksList', todoList);
  }
}
