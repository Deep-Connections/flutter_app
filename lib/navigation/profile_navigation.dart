import 'package:deep_connections/models/question/question_list.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/profile/birthday_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender_preferences/gender_preferences_profile_screen.dart';
import 'package:deep_connections/screens/profile/height_profile_screen.dart';
import 'package:deep_connections/screens/profile/name_profile_screen.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../services/user/user_service.dart';
import '../services/user/user_status.dart';

final profileRoutes = GoRoute(
    path: ProfileRoutes.main.path,
    redirect: (context, state) {
      final UserStatus userStatus = getIt<UserService>().userStatus;
      if (userStatus.isProfileComplete) return HomeRoutes.home.fullPath;
      if (state.fullPath == ProfileRoutes.main.path) {
        return ProfileRoutes.name.fullPath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: ProfileRoutes.name.path,
        builder: (context, state) {
          return NameProfileScreen(
              profileService: getIt(),
              navigateToNext: () =>
                  context.push(ProfileRoutes.birthday.fullPath));
        },
      ),
      GoRoute(
        path: ProfileRoutes.birthday.path,
        builder: (context, state) {
          return BirthdayProfileScreen(
            profileService: getIt(),
            navigateToNext: () => context.push(ProfileRoutes.gender.fullPath),
          );
        },
      ),
      GoRoute(
          path: ProfileRoutes.gender.path,
          builder: (context, state) {
            return GenderProfileScreen(
              profileService: getIt(),
              navigateToNext: () =>
                  context.push(ProfileRoutes.genderPreferences.fullPath),
            );
          }),
      GoRoute(
          path: ProfileRoutes.genderPreferences.path,
          builder: (context, state) {
            return GenderPreferencesProfileScreen(
              profileService: getIt(),
              navigateToNext: () => context.push(ProfileRoutes.height.fullPath),
            );
          }),
      GoRoute(
        path: ProfileRoutes.height.path,
        builder: (context, state) {
          return HeightProfileScreen(
              profileService: getIt(),
              navigateToNext: () {
                context.push(questions.first
                    .navigationFromBasePath(ProfileRoutes.main.path));
              });
        },
      ),
      ...List.generate(questions.length, (index) {
        final question = questions[index];
        final navigateNextPath = index < questions.length - 1
            ? questions[index + 1]
                .navigationFromBasePath(ProfileRoutes.main.path)
            : HomeRoutes.home.fullPath;
        return GoRoute(
          path: question.navigationPath,
          builder: (context, state) {
            return QuestionScreen(
              question: question,
              profileService: getIt(),
              navigate: () => context.push(navigateNextPath),
            );
          },
        );
      }),
    ]);
