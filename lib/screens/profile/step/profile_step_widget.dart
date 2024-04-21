import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:flutter/material.dart';

class ProfileStepWidget extends StatelessWidget {
  final ProfileNavigationStep step;
  final Future<void> Function() navigateToNext;

  const ProfileStepWidget(
      {super.key, required this.step, required this.navigateToNext});

  @override
  Widget build(BuildContext context) {
    final navigationStep = step;
    if (navigationStep is ProfileNavigationStepWithWidget) {
      return navigationStep.createWidget(getIt(), navigateToNext);
    } else if (navigationStep is Question) {
      return QuestionScreen(
        question: navigationStep,
        profileService: getIt(),
        navigate: navigateToNext,
      );
    } else {
      throw Exception("Unknown navigation step type: $navigationStep");
    }
  }
}
