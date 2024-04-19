import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/complete_profile/components/profile_nav_screen.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

generateProfileStepGraph(List<ProfileNavigationStep> steps, String basePath,
    {Future<void> Function(BuildContext)? navigateLast}) {
  return [
    ...List.generate(steps.length, (index) {
      final navigationStep = steps[index];
      final navigateNextPath = index < steps.length - 1
          ? steps[index + 1].navigationFromBasePath(basePath)
          : null;
      final previousPath =
          index > 0 ? steps[index - 1].navigationFromBasePath(basePath) : null;
      return GoRoute(
        path: navigationStep.navigationPath,
        pageBuilder: (context, state) {
          final Future<void> Function()? navigateToNext;
          if (navigateNextPath != null) {
            navigateToNext = () => context.push(navigateNextPath);
          } else if (navigateLast != null) {
            navigateToNext = () => navigateLast(context);
          } else {
            navigateToNext = () => Future.value();
          }
          Widget? profileNavWidget;
          if (navigationStep is ProfileNavigationStepWithWidget) {
            profileNavWidget =
                navigationStep.createWidget(getIt(), navigateToNext);
          } else if (navigationStep is Question) {
            profileNavWidget = QuestionScreen(
              question: navigationStep,
              profileService: getIt(),
              navigate: navigateToNext,
            );
          }
          return CupertinoPage(
              child: ProfileNavScreen(
                  navigatePrevious: index == 0
                      ? null
                      : (bool _) => context.canPop() || previousPath == null
                          ? context.pop()
                          : context.pushReplacement(previousPath),
                  navigationStep: navigationStep,
                  body: profileNavWidget!));
        },
      );
    }),
  ];
}
