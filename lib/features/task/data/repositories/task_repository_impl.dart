import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/features/task/domain/repositories/task_repository.dart';
import 'package:todo_app/features/task/data/datasources/task_local_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource taskLocalDataSource;

  TaskRepositoryImpl({required this.taskLocalDataSource});

  @override
  Future<Either<Failure, void>> changeStatusTask(int status, int id) async {
    try {
      return Right(await taskLocalDataSource.changeStatusTask(status, id));
    } on CacheFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> createTask(TaskModel taskModel) async {
    try {
      final res = await taskLocalDataSource.createTask(taskModel);
      return Right(res);
    } on CacheFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getTasks() async {
    try {
      return Right(await taskLocalDataSource.getTasks());
    } on CacheFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(TaskModel taskModel) async {
    try {
      final tasks = await taskLocalDataSource.deleteTask(taskModel);
      return Right(tasks);
    } on CacheFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllTasks() async {
    try {
      final tasks = await taskLocalDataSource.deleteAllTasks();
      return Right(tasks);
    } on CacheFailure catch (error) {
      return Left(error);
    }
  }
}
