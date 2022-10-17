part of 'task_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

// =================== Create Task States ===================
class CreateTaskLoadingState extends TasksState {}

class CreateTaskSuccessState extends TasksState {}

class CreateTaskErrorState extends TasksState {}

// ================== Get All Tasks States ==================
class GetAllTasksLoadingState extends TasksState {}

class GetAllTasksSuccessState extends TasksState {}

class GetAllTasksErrorState extends TasksState {}

// =================== Delete Task States ===================
class DeleteTaskLoadingState extends TasksState {}

class DeleteTaskSuccessState extends TasksState {}

class DeleteTaskErrorState extends TasksState {}

// ================= Delete All Tasks States ================
class DeleteAllTasksLoadingState extends TasksState {}

class DeleteAllTasksSuccessState extends TasksState {}

class DeleteAllTasksErrorState extends TasksState {}

// ================ Change Status Task State ================
class ChangeStatusTaskState extends TasksState {}

// ================ Selected Color Tasks State ==============
class SelectedColorState extends TasksState {
  final int index;

  const SelectedColorState(this.index);
  @override
  List<Object> get props => [index];
}

// ============= Change Selected Date Task State ============
class ChangeSelectedDateState extends TasksState {
  final DateTime date;

  const ChangeSelectedDateState(this.date);
  @override
  List<Object> get props => [date];
}
