import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/data/todo_data.dart';
import 'package:todo_provider/models/todo.dart';

class ManageToDosNotifier extends StateNotifier<List<ToDo>> {
  ManageToDosNotifier() : super([]);

  void addTask(ToDo task) {
    state = [...state, task];
  }

  void removeTask(int index) {
    state.removeAt(index);
    state = [...state];
  }

  void updateTask(ToDo task, int index) {
    List<ToDo> tempList = List.from(state);
    tempList[index] = tempList[index].copyWith(isDone: !state[index].isDone);
    state = [...tempList];
  }
}

final manageTasksProvider =
    StateNotifierProvider<ManageToDosNotifier, List<ToDo>>((ref) {
  return ManageToDosNotifier();
});
