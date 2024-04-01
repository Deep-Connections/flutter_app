import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/profile/birthday_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender_preferences/gender_preferences_profile_screen.dart';
import 'package:deep_connections/screens/profile/height_profile_screen.dart';
import 'package:deep_connections/screens/profile/name_profile_screen.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable.dart';
import '../services/user/user_service.dart';
import '../services/user/user_state.dart';

final profileRoutes = GoRoute(
    path: ProfileRoutes.main.path,
    redirect: (context, state) {
      final UserState userState = getIt<UserService>().userState;
      if (userState.isProfileComplete) return HomeRoutes.home.fullPath;
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
          return HeightProfileScreen(profileService: getIt());
        },
      ),
    ]);
