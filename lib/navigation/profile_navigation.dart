import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/profile/components/profile_nav_screen.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../models/navigation/profile_navigation_step.dart';
import '../models/user/user_status.dart';

final profileRoutes = GoRoute(
    path: ProfileRoutes.main.path,
    redirect: (context, state) {
      final UserStatus userStatus = getIt<UserStatusService>().userStatus;
      if (userStatus.isProfileComplete) return HomeRoutes.home.fullPath;
      if (state.fullPath == ProfileRoutes.main.path) {
        return userStatus.uncompletedStep
                ?.navigationFromBasePath(ProfileRoutes.main.path) ??
            HomeRoutes.home.fullPath;
      }
      return null;
    },
    routes: [
      ShellRoute(
          builder: (context, GoRouterState state, child) {
            final index = profileStepList.indexWhere((element) =>
                element.navigationFromBasePath(ProfileRoutes.main.path) ==
                state.fullPath);
            final navigationStep = profileStepList[index];
            final previousPath = index > 0
                ? profileStepList[index - 1]
                    .navigationFromBasePath(ProfileRoutes.main.path)
                : null;
            navigatePrevious() {
              if (context.canPop() || previousPath == null) {
                context.pop();
              } else {
                context.replace(previousPath);
              }
            }

            return ProfileNavScreen(
                navigatePrevious:
                    previousPath == null ? null : navigatePrevious,
                navigationStep: navigationStep,
                body: child);
          },
          routes: [
            ...List.generate(profileStepList.length, (index) {
              final navigationStep = profileStepList[index];
              final navigateNextPath = index < profileStepList.length - 1
                  ? profileStepList[index + 1]
                      .navigationFromBasePath(ProfileRoutes.main.path)
                  : HomeRoutes.home.fullPath;

              return GoRoute(
                path: navigationStep.navigationPath,
                builder: (context, state) {
                  navigateToNext() => context.push(navigateNextPath);
                  if (navigationStep is ProfileNavigationStepWithWidget) {
                    return navigationStep.createWidget(getIt(), navigateToNext);
                  }
                  if (navigationStep is Question) {
                    return QuestionScreen(
                      question: navigationStep,
                      profileService: getIt(),
                      navigate: navigateToNext,
                    );
                  }
                  return BaseScreen(
                      body: Center(
                          child: ElevatedButton(
                    onPressed: navigateToNext,
                    child: const Text('Next'),
                  )));
                },
              );
            }),
          ]),
    ]);
