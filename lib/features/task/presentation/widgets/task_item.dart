import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todo_app/features/task/domain/entities/task.dart';
import 'package:todo_app/features/task/presentation/widgets/button_sheet_button.dart';

class TasksItem extends StatelessWidget {
  const TasksItem({
    Key? key,
    required this.color,
    required this.taskEntity,
    required this.onPressedDelete,
    required this.onPressedComplete,
  }) : super(key: key);

  final Color color;
  final TaskEntity taskEntity;
  final void Function()? onPressedDelete;
  final void Function()? onPressedComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: NeumorphicButton(
        minDistance: -5,
        style: NeumorphicStyle(
          depth: 1,
          intensity: 4,
          color: color,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskEntity.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                      size: context.width / 25,
                    ),
                    SizedBox(width: context.width / 40),
                    Text(
                      '${taskEntity.startTime} - ${taskEntity.endTime}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  width: context.width - 70,
                  child: Text(
                    taskEntity.note,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            Neumorphic(
              padding: const EdgeInsets.all(0),
              style: const NeumorphicStyle(
                depth: -5,
                intensity: 5,
                color: AppColors.primary,
              ),
              child: const SizedBox(
                width: 3,
                height: 40,
              ),
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                taskEntity.status == 0 ? 'TODO' : 'Completed',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          ],
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: AppColors.gray.withOpacity(0.6),
            builder: (context) {
              return NeumorphicBackground(
                child: Neumorphic(
                  child: Padding(
                    padding: EdgeInsets.only(top: context.height / 20),
                    child: SizedBox(
                      height: context.height / 5,
                      child: Column(
                        children: [
                          if (taskEntity.status == 0)
                            ButtonSheetButton(
                              text: 'Complete Task',
                              icon: Icons.done,
                              iconColor: Colors.green,
                              textColor: Colors.green,
                              onPressed: onPressedComplete,
                            ),
                          SizedBox(height: context.height / 30),
                          ButtonSheetButton(
                            text: 'Delete Task',
                            iconColor: Colors.red,
                            textColor: Colors.red,
                            icon: Icons.delete_outline_rounded,
                            onPressed: onPressedDelete,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
