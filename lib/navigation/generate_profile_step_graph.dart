import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/screens/complete_profile/components/profile_nav_screen.dart';
import 'package:deep_connections/screens/profile/step/profile_step_widget.dart';
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

          return CupertinoPage(
              child: ProfileNavScreen(
                  navigatePrevious: index == 0
                      ? null
                      : (bool _) => context.canPop() || previousPath == null
                          ? context.pop()
                          : context.pushReplacement(previousPath),
                  navigationStep: navigationStep,
                  body: ProfileStepWidget(
                      step: navigationStep, navigateToNext: navigateToNext)));
        },
      );
    }),
  ];
}
