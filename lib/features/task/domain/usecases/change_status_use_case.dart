import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/task/domain/repositories/task_repository.dart';

class ChangeStatusUseCase {
  final TaskRepository taskRepository;

  ChangeStatusUseCase(this.taskRepository);

  Future<Either<Failure, void>> changeStatusTask(int status, int id) async {
    return taskRepository.changeStatusTask(status, id);
  }
}
