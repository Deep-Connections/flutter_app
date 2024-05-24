import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/navigation/graphs/bottom/additional_profile_nav_graph.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/profile/profile_photo_screen.dart';
import 'package:deep_connections/screens/profile/profile_screen.dart';
import 'package:deep_connections/screens/profile/profile_section_screen.dart';
import 'package:deep_connections/screens/profile/profile_section_step_screen.dart';
import 'package:deep_connections/screens/profile/profile_settings_screen.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:go_router/go_router.dart';

final bottomProfileNavGraph = [
  GoRoute(
    path: BottomNavigation.profile.path,
    pageBuilder: (context, state) => NoTransitionPage(
      child: ProfileScreen(
        authService: getIt(),
        profileService: getIt(),
        userStatusService: getIt(),
      ),
    ),
    routes: [
      GoRoute(
          path: ProfileRoutes.photos.path,
          builder: (context, state) =>
              ProfilePhotoScreen(profileService: getIt())),
      GoRoute(
          path: ProfileRoutes.settings.path,
          builder: (context, state) =>
              ProfileSettingsScreen(authService: getIt())),
      additionalProfileRoutes,
      // child route
      GoRoute(
        path: ProfileRoutes.section.path,
        redirect: (context, state) {
          final sectionPath =
              state.pathParameters[ProfileRoutes.section.pathParameter];
          final section = ProfileSection.fromPath(sectionPath);
          if (section == null) {
            return BottomNavigation.profile.path;
          }
          return null;
        },
        builder: (context, state) {
          final sectionPath =
              state.pathParameters[ProfileRoutes.section.pathParameter];
          final section = ProfileSection.fromPath(sectionPath);
          return ProfileSectionScreen(section: section!);
        },
        routes: [
          GoRoute(
            path: ProfileRoutes.step.path,
            redirect: (context, state) {
              final stepPath =
                  state.pathParameters[ProfileRoutes.step.pathParameter];
              final step = allProfileStepList
                  .firstWhereOrNull((step) => step.navigationPath == stepPath);
              if (step == null) {
                return BottomNavigation.profile.path;
              }
              if (!step.isEditable) {
                return ProfileRoutes.section.parameterPath([step.section.path]);
              }
              return null;
            },
            builder: (context, state) {
              final stepPath =
                  state.pathParameters[ProfileRoutes.step.pathParameter];
              final step = allProfileStepList
                  .firstWhere((step) => step.navigationPath == stepPath);
              return ProfileSectionStepScreen(step: step);
            },
          ),
        ],
      ),
    ],
  ),
];
