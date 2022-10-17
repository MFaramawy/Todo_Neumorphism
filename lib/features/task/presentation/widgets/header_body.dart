import 'package:intl/intl.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HeaderBody extends StatelessWidget {
  const HeaderBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Today',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          NeumorphicButton(
            minDistance: -4,
            style: const NeumorphicStyle(
              depth: 2.6,
              intensity: 4,
              boxShape: NeumorphicBoxShape.stadium(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'New Task',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, Routes.addTask),
          ),
        ],
      ),
    );
  }
}
