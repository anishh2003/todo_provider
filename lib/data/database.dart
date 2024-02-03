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
        return db.execute(
            'CREATE TABLE tasks(index TEXT, title TEXT, description TEXT, isDone bool)');
      },
      version: 1,
    );
  }

  Future<void> addTask(ToDo task, int index) async {
    final db = await database;

    db.insert('tasks', {
      'index': index,
      'title': task.title,
      'description': task.description,
      'isDone': task.isDone,
    });
  }

  Future<int> updateTask(ToDo task, index) async {
    final db = await database;
    return db.update(
      'tasks',
      {
        'index': index,
        'title': task.title,
        'description': task.description,
        'isDone': task.isDone,
      },
      where: 'index = ?',
      whereArgs: [index],
    );
  }

  Future<void> deleteTask(int index) async {
    final db = await database;
    db.delete(
      'tasks',
      where: 'index = ?',
      whereArgs: [index],
    );
  }

  Future<List<ToDo>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query('tasks');
    return data
        .map(
          (row) => ToDo(
            title: row['title'],
            description: row['description'],
            isDone: row['isDone'],
          ),
        )
        .toList();
  }
}
