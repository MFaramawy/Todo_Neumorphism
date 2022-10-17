import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/features/task/presentation/widgets/task_item.dart';
import 'package:todo_app/core/notification_helper/notification_helper.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: cubit.tasksList.length,
      itemBuilder: (context, index) {
        final task = cubit.tasksList[index];
        final selectedDate = cubit.selectedDate;
        final parseTaskDate = DateFormat.yMMMMd().parse(task.date);
        final condition = task.repeat == 'Daily';
        final condition1 =
            task.date == DateFormat.yMMMMd().format(selectedDate);
        final condition2 = task.repeat == 'Weekly' &&
            selectedDate.difference(parseTaskDate).inDays % 7 == 0;
        final condition4 =
            task.repeat == 'Monthly' && parseTaskDate.day == selectedDate.day;

        if (condition || condition1 || condition2 || condition4) {
          NotifyHelper.scheduledNotification(task);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 700),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: TasksItem(
                color: cubit.colors[task.color],
                onPressedDelete: () {
                  cubit.deleteTask(task);
                  Navigator.pop(context);
                  NotifyHelper.cancelNotification(task);
                },
                onPressedComplete: () {
                  cubit.changeStatusTask(task.id!);
                  Navigator.pop(context);
                  NotifyHelper.cancelNotification(task);
                },
                taskEntity: task,
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
