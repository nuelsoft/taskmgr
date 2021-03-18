import 'package:sqflite/sqflite.dart';
import 'package:todo/core/models/task.dart';

class DatabaseService {
  static Database db;

  static Future<void> connect() async {
    String databasesPath = await getDatabasesPath();
    String path = "${databasesPath}todo.db";

    // await deleteDatabase(path);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Task (id INTEGER PRIMARY KEY, category TEXT, course TEXT, details TEXT,'
          ' date INTEGER, hour INTEGER, minute INTEGER, duration INTEGER, dayGroup TEXT )');
    });
  }

  static Future<void> store(Task task) async {
    await db.transaction((txn) async {
      await txn.insert('Task', task.json);
    });
  }

  static Future<List<Task>> pull(String day) async {
    if (db == null) await connect();
    List<Map<String, dynamic>> out =
        await db.query("Task", where: "dayGroup = $day");
    return List<Task>.from(Task.fromList(out))
      ..sort((a, b) => a.aggregateTime > b.aggregateTime ? 1 : -1);
  }
}
