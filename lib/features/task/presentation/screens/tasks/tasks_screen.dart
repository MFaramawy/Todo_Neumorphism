import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/features/task/presentation/widgets/tasks_list.dart';
import 'package:todo_app/features/task/presentation/widgets/header_body.dart';
import 'package:todo_app/features/task/presentation/widgets/time_line_date.dart';
import 'package:todo_app/features/task/presentation/widgets/custom_app_bar.dart';
import 'package:todo_app/features/task/presentation/widgets/no_tasks_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = TasksCubit.get(context);
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Scaffold(
          body: NeumorphicBackground(
            child: Column(
              children: [
                SizedBox(height: context.height / 25),
                CustomAppBar(cubit: cubit),
                SizedBox(height: context.height / 70),
                const HeaderBody(),
                SizedBox(height: context.height / 70),
                TimeLineDate(cubit: cubit),
                SizedBox(height: context.height / 70),
                Expanded(
                  child: cubit.tasksList.isNotEmpty
                      ? TasksList(cubit: cubit)
                      : const NoTasksWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
