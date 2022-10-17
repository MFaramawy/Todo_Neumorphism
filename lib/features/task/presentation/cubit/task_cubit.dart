import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/db_helper/db_helper.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/core/notification_helper/notification_helper.dart';
import 'package:todo_app/features/task/domain/usecases/get_tasks_use_case.dart';
import 'package:todo_app/features/task/domain/usecases/create_task_use_case.dart';
import 'package:todo_app/features/task/domain/usecases/delete_task_use_case.dart';
import 'package:todo_app/features/task/domain/usecases/change_status_use_case.dart';
part 'task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final GetAllTasksUseCase getAllTasksUseCase;
  final ChangeStatusUseCase changeStatusUseCase;
  TasksCubit({
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getAllTasksUseCase,
    required this.changeStatusUseCase,
  }) : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of(context);

  final List<Color> colors = [
    Colors.deepOrange.shade200,
    Colors.cyan.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.purple.shade200,
  ];

  int selectedColor = 0;
  String repeatValue = '';
  String reminderValue = '5';
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final List<String> reminder = ['5', '10', '15', '20'];
  final List<String> repeat = ['None', 'Daily', 'Weekly', 'Monthly'];
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();

  void changeColor(int index) {
    emit(SelectedColorState(index));
    selectedColor = index;
  }

  void customShowDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    ).then((value) {
      value != null
          ? dateController.text = DateFormat.yMMMMd().format(value)
          : null;
    });
  }

  Future<void> createTask() async {
    emit(CreateTaskLoadingState());
    TaskModel taskModel = TaskModel(
      status: 0,
      repeat: repeatValue,
      color: selectedColor,
      date: dateController.text,
      note: noteController.text,
      title: titleController.text,
      endTime: endTimeController.text,
      reminder: int.parse(reminderValue),
      startTime: startTimeController.text,
    );
    await createTaskUseCase.createTask(taskModel).then((value) {
      NotifyHelper.scheduledNotification(taskModel);
      emit(CreateTaskSuccessState());
    }).catchError((error) {
      emit(CreateTaskErrorState());
    });
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    emit(DeleteTaskLoadingState());
    await deleteTaskUseCase.deleteTask(taskModel).then((value) async {
      emit(DeleteTaskSuccessState());
      await getAllTasks();
    }).catchError((error) {
      emit(DeleteTaskErrorState());
    });
  }

  Future<void> deleteAllTasks() async {
    emit(DeleteAllTasksLoadingState());
    await deleteTaskUseCase.deleteAllTaskS().then((value) async {
      await getAllTasks();
      emit(DeleteAllTasksSuccessState());
    }).catchError((error) {
      emit(DeleteAllTasksErrorState());
    });
  }

  List<TaskModel> tasksList = [];
  Future<void> getAllTasks() async {
    emit(GetAllTasksLoadingState());
    tasksList = [];
    await getAllTasksUseCase.getAllTasks().then((value) {
      value.fold((failure) => failure, (data) {
        tasksList.addAll(data.map((e) => TaskModel.fromJson(e)).toList());
        emit(GetAllTasksSuccessState());
      });
    }).catchError((error) {
      emit(GetAllTasksErrorState());
    });
  }

  Future<void> changeStatusTask(int id) async {
    await DBHelper.update(id, 1);
    await getAllTasks();
    emit(ChangeStatusTaskState());
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    emit(ChangeSelectedDateState(date));
  }

  void clearController() {
    titleController.clear();
    noteController.clear();
    dateController.clear();
    endTimeController.clear();
    startTimeController.clear();
  }
}
