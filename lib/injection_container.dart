import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'features/task/domain/usecases/delete_task_use_case.dart';
import 'features/task/data/repositories/task_repository_impl.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/features/task/domain/usecases/get_tasks_use_case.dart';
import 'package:todo_app/features/task/domain/repositories/task_repository.dart';
import 'package:todo_app/features/task/domain/usecases/create_task_use_case.dart';
import 'package:todo_app/features/task/domain/usecases/change_status_use_case.dart';
import 'package:todo_app/features/task/data/datasources/task_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerLazySingleton<TasksCubit>(() => TasksCubit(
      createTaskUseCase: sl(),
      deleteTaskUseCase: sl(),
      changeStatusUseCase: sl(),
      getAllTasksUseCase: sl()));

  // Use cases
  sl.registerLazySingleton<CreateTaskUseCase>(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton<DeleteTaskUseCase>(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton<ChangeStatusUseCase>(
      () => ChangeStatusUseCase(sl()));
  sl.registerLazySingleton<GetAllTasksUseCase>(() => GetAllTasksUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(taskLocalDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(sl()));

  // Core

  //! External
  final String path = await getDatabasesPath() + AppStrings.dbPath;
  final db = await openDatabase(path);
  sl.registerLazySingleton(() => db);
}
