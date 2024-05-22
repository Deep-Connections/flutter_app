import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/navigation/graphs/additional_profile_nav_graph.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/chat_list_screen.dart';
import 'package:deep_connections/screens/components/bottom_nav_bar.dart';
import 'package:deep_connections/screens/profile/profile_photo_screen.dart';
import 'package:deep_connections/screens/profile/profile_screen.dart';
import 'package:deep_connections/screens/profile/profile_section_screen.dart';
import 'package:deep_connections/screens/profile/profile_section_step_screen.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final _profileNavKey = GlobalKey<NavigatorState>(debugLabel: 'profileShell');
final _chatNavKey = GlobalKey<NavigatorState>(debugLabel: 'chatShell');

final bottomNavigation = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return BottomNavBar(
        navigationShell: navigationShell, routes: BottomNavigation.values);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: _chatNavKey,
      routes: [
        GoRoute(
          path: BottomNavigation.chat.path,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChatListScreen(
                  chatService: getIt(), profileService: getIt())),
          routes: const [],
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _profileNavKey,
      routes: [
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
                builder: (context, state) {
                  return ProfilePhotoScreen(profileService: getIt());
                }),
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
                    final step = allProfileStepList.firstWhereOrNull(
                        (step) => step.navigationPath == stepPath);
                    if (step == null) {
                      return BottomNavigation.profile.path;
                    }
                    if (!step.isEditable) {
                      return ProfileRoutes.section
                          .parameterPath([step.section.path]);
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
      ],
    ),
  ],
);
