import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/features/app/data/models/onboarding_model.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: NeumorphicBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.width,
              height: context.height / 2.10,
              padding: const EdgeInsets.all(12),
              child: PageView.builder(
                itemCount: 2,
                controller: controller,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) => Column(
                      children: [
                        OnBoardingModel.onBoardingData[index].shape,
                        SizedBox(height: context.height / 24),
                        Text(
                          OnBoardingModel.onBoardingData[index].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: context.height / 55),
                        Text(
                          OnBoardingModel.onBoardingData[index].body,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: context.height / 10),
            SmoothPageIndicator(
              count: 2,
              controller: controller,
              effect: WormEffect(
                dotColor: AppColors.gray,
                spacing: context.width / 45,
                dotWidth: context.width / 40,
                dotHeight: context.height / 80,
                activeDotColor: AppColors.primary,
              ),
            ),
            SizedBox(height: context.height / 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NeumorphicButton(
                  minDistance: -5,
                  style: const NeumorphicStyle(
                    depth: 5,
                    intensity: 5,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: context.width / 12,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    controller.page == OnBoardingModel.onBoardingData.length - 2
                        ? ''
                        : controller.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutSine);
                  },
                ),
                NeumorphicButton(
                  minDistance: -5,
                  style: const NeumorphicStyle(
                    depth: 5,
                    intensity: 5,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: context.width / 12,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    controller.page == OnBoardingModel.onBoardingData.length - 1
                        ? Navigator.pushNamedAndRemoveUntil(
                            context, Routes.tasks, (route) => false)
                        : controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutSine);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
