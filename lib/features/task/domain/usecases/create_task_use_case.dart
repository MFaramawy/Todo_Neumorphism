import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/features/task/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository taskRepository;

  CreateTaskUseCase(this.taskRepository);

  Future<Either<Failure, void>> createTask(TaskModel taskModel) async {
    return taskRepository.createTask(taskModel);
  }
}
