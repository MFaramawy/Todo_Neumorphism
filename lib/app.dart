import 'core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/config/routes/app_routes.dart';

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>()..getAllTasks(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initialRoute,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(primaryColor: AppColors.primary),
      ),
    );
  }
}
