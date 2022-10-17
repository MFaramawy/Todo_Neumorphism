import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';

class DBHelper {
  static Database? db;
  static const int version = AppStrings.dbVersion;
  static const String tableName = AppStrings.tableName;

  static Future<void> initDb() async {
    if (db != null) {
      return;
    } else {
      try {
        String path = join(await getDatabasesPath(), AppStrings.dbPath);
        db = await openDatabase(
          path,
          version: version,
          onCreate: (Database db, int version) async {
            return db.execute('CREATE TABLE $tableName ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                'title STRING, note TEXT, date STRING,'
                'startTime STRING, endTime STRING,'
                'reminder INTEGER, repeat STRING,'
                'color INTEGER,'
                'status INTEGER)');
          },
        );
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  static Future<int> insert(TaskModel task) async {
    try {
      return await db!.insert(tableName, task.toJson());
    } catch (e) {
      return 90000;
    }
  }

  static Future<int> delete(TaskModel task) async {
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    final data = await db!.query(tableName);
    return data;
  }

  static Future<int> deleteAll() async {
    return await db!.delete(tableName);
  }

  static Future<int> update(int id, int status) async {
    return await db!.rawUpdate('''
    UPDATE tasks
    SET status = ?
    WHERE id = ?
    ''', [status, id]);
  }
}
