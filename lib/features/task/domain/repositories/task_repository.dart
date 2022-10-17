import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, void>> deleteAllTasks();
  Future<Either<Failure, void>> createTask(TaskModel taskModel);

  Future<Either<Failure, void>> deleteTask(TaskModel taskModel);
  Future<Either<Failure, List<Map<String, dynamic>>>> getTasks();
  Future<Either<Failure, void>> changeStatusTask(int status, int id);
}
