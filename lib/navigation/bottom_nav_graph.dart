import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/chat_screen.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/bottom_nav_bar.dart';
import 'package:deep_connections/screens/profile/profile_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final _profileNavKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _chatNavKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final bottomNavigation = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return BottomNavBar(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: _profileNavKey,
      routes: [
        GoRoute(
          path: BottomNavigation.profile.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
          routes: [
            GoRoute(
              path: 'details',
              builder: (context, state) => BaseScreen(body: Container()),
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _chatNavKey,
      routes: [
        GoRoute(
          path: BottomNavigation.chat.fullPath,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChatScreen(),
          ),
          routes: [
            // child route
            GoRoute(
              path: 'details',
              builder: (context, state) => BaseScreen(body: Container()),
            ),
          ],
        ),
      ],
    ),
  ],
);
