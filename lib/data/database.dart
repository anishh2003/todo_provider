import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_provider/models/todo.dart';

class TaskDataSource {
  static late SharedPreferences _sharedPreferences;

  Future<void> initialiseDatabase() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> updateList(List<ToDo> todos) async {
    List<String> spList =
        todos.map((item) => json.encode(item.toMap())).toList();
    await _sharedPreferences.setStringList('TaskList', spList);
  }

  List<ToDo> getAllTasks() {
    List<String>? spList = _sharedPreferences.getStringList('TaskList');
    List<ToDo> storedList;
    storedList = spList != null
        ? spList.map((item) => ToDo.fromJson(item)).toList()
        : [];
    return storedList;
  }
}
