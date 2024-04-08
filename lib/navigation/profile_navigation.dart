import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/complete_profile/components/profile_nav_screen.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../models/navigation/profile_navigation_step.dart';
import '../models/user/user_status.dart';

final profileRoutes = GoRoute(
    path: CompleteProfileRoutes.main.path,
    redirect: (context, state) async {
      final UserStatus userStatus = await getIt<UserStatusService>().userStatus;
      if (userStatus.isProfileComplete)
        return BottomNavigation.profile.fullPath;
      if (state.fullPath == CompleteProfileRoutes.main.path) {
        return userStatus.uncompletedStep
                ?.navigationFromBasePath(CompleteProfileRoutes.main.path) ??
            BottomNavigation.profile.fullPath;
      }
      return null;
    },
    routes: [
      ...List.generate(profileStepList.length, (index) {
        final navigationStep = profileStepList[index];
        final navigateNextPath = index < profileStepList.length - 1
            ? profileStepList[index + 1]
                .navigationFromBasePath(CompleteProfileRoutes.main.path)
            : null;
        final previousPath = index > 0
            ? profileStepList[index - 1]
                .navigationFromBasePath(CompleteProfileRoutes.main.path)
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
