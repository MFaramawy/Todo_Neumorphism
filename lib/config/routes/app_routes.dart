import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/features/task/presentation/screens/tasks/tasks_screen.dart';
import 'package:todo_app/features/app/presentation/screens/splash/splash_screen.dart';
import 'package:todo_app/features/task/presentation/screens/tasks/add_task_screen.dart';
import 'package:todo_app/features/app/presentation/screens/onboarding/onboarding_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String tasks = '/Tasks';
  static const String addTask = '/AddTask';
  static const String onBoardingScreen = '/OnBoardingScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoardingScreen:
        return CupertinoPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.tasks:
        return CupertinoPageRoute(builder: (_) => const TaskScreen());
      case Routes.addTask:
        return CupertinoPageRoute(builder: (_) => const AddTaskScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return CupertinoPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
