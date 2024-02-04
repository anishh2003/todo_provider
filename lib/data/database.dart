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


// class TaskDataSource {
//   static Database? _database;

//   Future<Database> get database async {
//     _database ??= await _initialiseDatabase();
//     return _database!;
//   }

//   Future<Database> _initialiseDatabase() async {
//     final dbPath = await sql.getDatabasesPath();
//     return await sql.openDatabase(
//       path.join(dbPath, 'tasksTable.db'),
//       onCreate: (db, version) {
//         //index has been put into double quotes as index is a reserved keyword in sql
//         return db.execute(
//             'CREATE TABLE tasks("index" TEXT PRIMARY KEY, title TEXT, description TEXT, isDone INTEGER)');
//       },
//       version: 2,
//     );
//   }

//   Future<void> addTask(ToDo task, int index) async {
//     final db = await database;

//     await db.insert(
//       'tasks',
//       {
//         '"index"': index,
//         'title': task.title,
//         'description': task.description,
//         'isDone': task.isDone ? 1 : 0,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<int> updateTask(ToDo task, index) async {
//     final db = await database;
//     return await db.update(
//       'tasks',
//       {
//         '"index"': index,
//         'title': task.title,
//         'description': task.description,
//         'isDone': task.isDone ? 1 : 0,
//       },
//       where: '"index" = ?',
//       whereArgs: [index],
//     );
//   }

//   Future<void> deleteTask(int index) async {
//     final db = await database;
//     await db.delete(
//       'tasks',
//       where: '"index" = ?',
//       whereArgs: [index],
//     );
//   }

//   Future<List<ToDo>>? getAllTasks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> data = await db.query('tasks');
//     return data
//         .map(
//           (row) => ToDo(
//             title: row['title'],
//             description: row['description'],
//             isDone: row['isDone'] == 1 ? true : false,
//           ),
//         )
//         .toList();
//   }

//   Future<void> deleteAllTasks() async {
//     final db = await database;
//     await db.delete(
//       'tasks',
//     );
//   }
// }
