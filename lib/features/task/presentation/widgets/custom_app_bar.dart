import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/core/notification_helper/notification_helper.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height / 12,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxHeight + constraints.maxWidth;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: context.width / 2.6),
              NeumorphicText(
                'Tasks',
                style: const NeumorphicStyle(depth: 2, intensity: 5),
                textStyle: NeumorphicTextStyle(fontSize: size / 16),
              ),
              SizedBox(width: size / 3.7),
              NeumorphicButton(
                minDistance: -5,
                padding: EdgeInsets.zero,
                style: const NeumorphicStyle(
                  depth: 2,
                  intensity: 4,
                ),
                child: NeumorphicIcon(
                  Icons.delete_forever_rounded,
                  size: size / 18,
                  style: const NeumorphicStyle(
                    depth: 0,
                    intensity: 0,
                    color: Colors.red,
                  ),
                ),
                onPressed: () async {
                  await cubit.deleteAllTasks();
                  await NotifyHelper.cancelAllNotification();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
