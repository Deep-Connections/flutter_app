import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/complete_profile/components/profile_nav_screen.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../config/injectable/injectable.dart';
import '../../models/navigation/profile_navigation_step.dart';
import '../../models/user/user_status.dart';

final initialProfileRoutes = GoRoute(
    path: CompleteProfileRoutes.main.path,
    redirect: (context, state) async {
      final UserStatus userStatus = await getIt<UserStatusService>().userStatus;
      if (userStatus.isProfileComplete) {
        return homeRoute;
      }
      if (state.fullPath == CompleteProfileRoutes.main.fullPath) {
        return userStatus.uncompletedStep
                ?.navigationFromBasePath(CompleteProfileRoutes.main.fullPath) ??
            homeRoute;
      }
      return null;
    },
    routes: [
      ...List.generate(initialProfileStepList.length, (index) {
        final navigationStep = initialProfileStepList[index];
        final navigateNextPath = index < initialProfileStepList.length - 1
            ? initialProfileStepList[index + 1]
                .navigationFromBasePath(CompleteProfileRoutes.main.fullPath)
            : null;
        final previousPath = index > 0
            ? initialProfileStepList[index - 1]
                .navigationFromBasePath(CompleteProfileRoutes.main.fullPath)
            : null;
        return GoRoute(
          path: navigationStep.navigationPath,
          pageBuilder: (context, state) {
            navigateToNext() async => navigateNextPath != null
                ? context.push(navigateNextPath)
                : null;
            Widget? profileNavWidget;
            if (navigationStep is ProfileNavigationStepWithWidget) {
              profileNavWidget =
                  navigationStep.createWidget(getIt(), navigateToNext);
            }
            if (navigationStep is Question) {
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
    ]);
