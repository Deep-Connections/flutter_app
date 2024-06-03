import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/profile_nav_screen.dart';
import 'package:deep_connections/screens/profile/step/profile_step_widget.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

generateProfileStepGraph(List<ProfileNavigationStep> steps, String basePath,
    {Future<void> Function(Profile profile)? onFinishProfile,
    Function(BuildContext)? finishLater}) {
  return [
    ...List.generate(steps.length, (index) {
      final navigationStep = steps[index];
      final nextPath = index < steps.length - 1
          ? steps[index + 1].navigationFromBasePath(basePath)
          : null;
      final previousPath =
          index > 0 ? steps[index - 1].navigationFromBasePath(basePath) : null;
      return GoRoute(
        path: navigationStep.navigationPath,
        pageBuilder: (context, state) {
          return CupertinoPage(
              child: ProfileNavScreen(
            navigatePrevious: index == 0
                ? null
                : (bool _) => context.canPop() || previousPath == null
                    ? context.pop()
                    : context.pushReplacement(previousPath),
            navigationStep: navigationStep,
            finishLater: finishLater,
            body: ProfileStepWidget(
              step: navigationStep,
              navigate: nextPath != null ? (_) => context.push(nextPath) : null,
              afterProfileUpdate:
                  index == steps.lastIndex && onFinishProfile != null
                      ? onFinishProfile
                      : null,
              profileService: getIt(),
              submitText: LocKey((loc) =>
                  nextPath != null ? loc.general_next : loc.general_submit),
            ),
          ));
        },
      );
    }),
  ];
}
