import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/task/domain/repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository taskRepository;

  GetAllTasksUseCase(this.taskRepository);

  Future<Either<Failure, List<Map<String, dynamic>>>> getAllTasks() async {
    return taskRepository.getTasks();
  }
}
