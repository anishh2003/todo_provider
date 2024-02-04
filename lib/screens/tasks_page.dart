import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_provider/models/todo.dart';
import 'package:todo_provider/providers/manageTodos_provider.dart';

class ToDoPage extends ConsumerStatefulWidget {
  const ToDoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToDoPageState();
}

class _ToDoPageState extends ConsumerState<ToDoPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    // Use Future.delayed to defer the execution until after the build phase.
    Future.delayed(Duration.zero, () {
      ref.read(manageTasksProvider.notifier).getallStoredTasks() ?? [];
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<ToDo?> _showMyDialog(BuildContext context) async {
    titleController.text = '';
    descriptionController.text = '';
    return showDialog<ToDo>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new ToDo Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    fillColor: Color(0XFF322a1d),
                    labelText: 'Title',
                    border: UnderlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    fillColor: Color(0XFF322a1d),
                    labelText: 'Description',
                    border: UnderlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                ToDo newItem = ToDo(
                    title: titleController.text,
                    description: descriptionController.text,
                    isDone: false);

                if (titleController.text != '' &&
                    descriptionController.text != '') {
                  Navigator.of(context).pop(newItem);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final dummyToDos = ref.watch(tasksProvider);
    final manageTasks = ref.watch(manageTasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        backgroundColor: Colors.amber,
        actions: [
          Row(
            children: [
              const Text("Delete All"),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(manageTasksProvider.notifier).removeAllTasks();
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          ToDo? newItem = await _showMyDialog(context);
          ref.read(manageTasksProvider.notifier).addTask(newItem!);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: manageTasks.length,
              itemBuilder: (context, index) {
                final todo = manageTasks[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (_) {
                              ref
                                  .read(manageTasksProvider.notifier)
                                  .removeTask(index);
                            },
                          ),
                        ],
                      ),
                      key: ValueKey(index),
                      child: ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        trailing: Checkbox(
                          value: todo.isDone,
                          onChanged: (value) {
                            ref
                                .read(manageTasksProvider.notifier)
                                .updateTask(todo, index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
