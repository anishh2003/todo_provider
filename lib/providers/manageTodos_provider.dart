import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/data/database.dart';
import 'package:todo_provider/models/todo.dart';

class ManageToDosNotifier extends StateNotifier<List<ToDo>> {
  ManageToDosNotifier(this.datasource) : super([]);

  TaskDataSource datasource;

  List<ToDo>? getallStoredTasks() {
    final storedList = datasource.getAllTasks();
    state = storedList;
    return state;
  }

  void addTask(ToDo task) {
    state = [...state, task];
    datasource.updateList(state);
  }

  void removeTask(int index) {
    state.removeAt(index);
    state = [...state];
    datasource.updateList(state);
  }

  void updateTask(ToDo task, int index) {
    List<ToDo> tempList = List.from(state);
    tempList[index] = tempList[index].copyWith(isDone: !state[index].isDone);
    state = [...tempList];
    datasource.updateList(state);
  }

  void removeAllTasks() {
    state = [];
    datasource.updateList(state);
  }
}

final manageTasksProvider =
    StateNotifierProvider<ManageToDosNotifier, List<ToDo>>((ref) {
  return ManageToDosNotifier(TaskDataSource());
});
