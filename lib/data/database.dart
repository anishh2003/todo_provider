import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_provider/models/todo.dart';

class TaskDataSource {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initialiseDatabase();
    return _database!;
  }

  Future<Database> _initialiseDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'tasksTable.db'),
      onCreate: (db, version) {
        //index has been put into double quotes as index is a reserved keyword in sql
        return db.execute(
            'CREATE TABLE tasks("index" TEXT PRIMARY KEY, title TEXT, description TEXT, isDone INTEGER)');
      },
      version: 2,
    );
  }

  Future<void> addTask(ToDo task, int index) async {
    final db = await database;

    await db.insert(
      'tasks',
      {
        '"index"': index,
        'title': task.title,
        'description': task.description,
        'isDone': task.isDone ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTask(ToDo task, index) async {
    final db = await database;
    return await db.update(
      'tasks',
      {
        '"index"': index,
        'title': task.title,
        'description': task.description,
        'isDone': task.isDone ? 1 : 0,
      },
      where: '"index" = ?',
      whereArgs: [index],
    );
  }

  Future<void> deleteTask(int index) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: '"index" = ?',
      whereArgs: [index],
    );
  }

  Future<List<ToDo>>? getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query('tasks');
    return data
        .map(
          (row) => ToDo(
            title: row['title'],
            description: row['description'],
            isDone: row['isDone'] == 1 ? true : false,
          ),
        )
        .toList();
  }

  Future<void> deleteAllTasks() async {
    final db = await database;
    await db.delete(
      'tasks',
    );
  }
}
