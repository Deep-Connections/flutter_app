import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/navigation/graphs/additional_profile_nav_graph.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/chat_list_screen.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/bottom_nav_bar.dart';
import 'package:deep_connections/screens/profile/profile_screen.dart';
import 'package:deep_connections/screens/profile/profile_section_screen.dart';
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
          routes: [],
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
                  builder: (context, state) => BaseScreen(body: Container()),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
