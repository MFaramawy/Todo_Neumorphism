import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/db_helper/db_helper.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<void> deleteAllTasks();
  Future<void> deleteTask(TaskModel taskModel);
  Future<void> createTask(TaskModel taskModel);
  Future<List<Map<String, dynamic>>> getTasks();
  Future<void> changeStatusTask(int status, int id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  Database? db;

  TaskLocalDataSourceImpl(this.db);

  @override
  Future<int> createTask(TaskModel taskModel) async {
    try {
      return DBHelper.insert(taskModel);
    } catch (e) {
      return 90000;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTasks() async {
    return DBHelper.query();
  }

  @override
  Future<void> changeStatusTask(int status, int id) async {
    await DBHelper.update(id, status);
  }

  @override
  Future<void> deleteTask(TaskModel taskModel) async {
    await DBHelper.delete(taskModel);
  }

  @override
  Future<void> deleteAllTasks() async {
    await DBHelper.deleteAll();
  }
}
