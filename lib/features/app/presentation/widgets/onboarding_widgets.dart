import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Shape1 extends StatelessWidget {
  const Shape1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.height + context.width;
    return SizedBox(
      width: context.width,
      height: size / 5.8,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxWidth + constraints.maxHeight;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Neumorphic(
                style: const NeumorphicStyle(
                  depth: 5,
                  intensity: 2,
                  lightSource: LightSource.top,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: SizedBox(
                  width: size / 8,
                  height: size / 9,
                  child: Icon(
                    Icons.add_rounded,
                    size: size / 12,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  depth: 5,
                  intensity: 5,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: size / 2.6,
                  child: Icon(
                    Icons.checklist_rounded,
                    size: size / 3,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Shape2 extends StatelessWidget {
  const Shape2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.height + context.width;
    return SizedBox(
      width: size / 5.5,
      height: size / 5.8,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.minWidth, height = constraints.minHeight;
          return Stack(
            alignment: Alignment.center,
            children: [
              NeumorphicIcon(
                Icons.watch_later_outlined,
                size: size / 5,
                style: const NeumorphicStyle(
                  depth: 5,
                  intensity: 2,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
              ),
              Positioned(
                top: height / 10,
                left: width / 2,
                child: Text(
                  '12',
                  style: TextStyle(
                    fontSize: size / 95,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: height / 7,
                right: width / 10,
                child: Text(
                  '4',
                  style: TextStyle(
                    fontSize: size / 95,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
