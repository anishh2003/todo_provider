import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_provider/models/todo.dart';
import 'package:todo_provider/screens/tasks_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox('TasksBox');

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ToDoPage(),
        ),
      ),
    );
  }
}
