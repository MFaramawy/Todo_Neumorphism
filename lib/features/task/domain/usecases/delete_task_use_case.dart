import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/features/task/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository taskRepository;

  DeleteTaskUseCase(this.taskRepository);

  Future<Either<Failure, void>> deleteTask(TaskModel taskModel) async =>
      await taskRepository.deleteTask(taskModel);

  Future<Either<Failure, void>> deleteAllTaskS() async =>
      await taskRepository.deleteAllTasks();
}
