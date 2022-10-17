import 'package:todo_app/core/utils/app_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';

class TimeLineDate extends StatelessWidget {
  const TimeLineDate({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: Neumorphic(
        style: const NeumorphicStyle(depth: 2, intensity: 1),
        child: DatePicker(
          DateTime.now(),
          dayTextStyle: textTheme.bodySmall!,
          deactivatedColor: AppColors.gray,
          selectionColor: AppColors.primary,
          monthTextStyle: textTheme.bodySmall!,
          initialSelectedDate: cubit.selectedDate,
          dateTextStyle: textTheme.titleLarge!.copyWith(color: AppColors.gray),
          onDateChange: (date) => cubit.changeSelectedDate(date),
        ),
      ),
    );
  }
}
