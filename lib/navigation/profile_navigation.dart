import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/profile/birthday_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender_preferences/gender_preferences_profile_screen.dart';
import 'package:deep_connections/screens/profile/name_profile_screen.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../models/navigation/profile_navigation_step.dart';
import '../services/user/user_service.dart';
import '../services/user/user_status.dart';

final profileRoutes = GoRoute(
    path: ProfileRoutes.main.path,
    redirect: (context, state) {
      final UserStatus userStatus = getIt<UserService>().userStatus;
      if (userStatus.isProfileComplete) return HomeRoutes.home.fullPath;
      if (state.fullPath == ProfileRoutes.main.path) {
        return profileStepList.first
            .navigationFromBasePath(ProfileRoutes.main.path);
      }
      return null;
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
            if (navigationStep is NameProfileNavigationStep) {
              return NameProfileScreen(
                  profileService: getIt(), navigateToNext: navigateToNext);
            }
            if (navigationStep is BirthdateProfileNavigationStep) {
              return BirthdayProfileScreen(
                  profileService: getIt(), navigateToNext: navigateToNext);
            }
            if (navigationStep is GenderProfileNavigationStep) {
              return GenderProfileScreen(
                  profileService: getIt(), navigateToNext: navigateToNext);
            }
            if (navigationStep is GenderPreferencesProfileNavigationStep) {
              return GenderPreferencesProfileScreen(
                  profileService: getIt(), navigateToNext: navigateToNext);
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
    ]);
