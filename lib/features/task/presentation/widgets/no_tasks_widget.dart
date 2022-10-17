import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/utils/assets_manager.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NoTasksWidget extends StatelessWidget {
  const NoTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(height: context.height / 7),
          Neumorphic(
            padding: const EdgeInsets.all(10),
            style: const NeumorphicStyle(
              depth: 4,
              intensity: 4,
              lightSource: LightSource.bottomRight,
            ),
            child: SvgPicture.asset(
              AssetsManager.noTasks,
              fit: BoxFit.cover,
              width: context.width / 5,
              height: context.height / 6,
            ),
          ),
          SizedBox(height: context.height / 40),
          Text(
            'You do not have tasks today \nEnjoy your time',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      );
}
