import 'package:flutter/material.dart';
import 'package:todo_app/features/app/presentation/widgets/onboarding_widgets.dart';

class OnBoardingModel {
  final String body;
  final String title;
  final Widget shape;

  OnBoardingModel({
    required this.body,
    required this.title,
    required this.shape,
  });

  static final List<OnBoardingModel> onBoardingData = [
    OnBoardingModel(
      title: 'Add todo with one tap',
      body: 'Todo can be add with one tap on complicated work is required',
      shape: const Shape1(),
    ),
    OnBoardingModel(
      title: 'Time tracker',
      body:
          'Don\'t bother keeping track of time to get your tasks done, we take care of that',
      shape: const Shape2(),
    ),
  ];
}
