import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/user/user_status.dart';
import 'package:deep_connections/navigation/graphs/auth_nav_graph.dart';
import 'package:deep_connections/navigation/graphs/bottom_nav_graph.dart';
import 'package:deep_connections/navigation/graphs/initial_profile_nav_graph.dart';
import 'package:deep_connections/navigation/refresh_listenable.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/message_list_screen.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  refreshListenable:
      GoRouterRefreshListenable(getIt<UserStatusService>().userStatusStream),
  initialLocation: homeRoute,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final UserStatus userStatus = await getIt<UserStatusService>().userStatus;
    final path = state.fullPath;
    if (path == null) return AuthRoutes.main.fullPath;
    if (!userStatus.isAuthenticated) {
      if (!path.startsWith(AuthRoutes.main.fullPath)) {
        return AuthRoutes.main.fullPath;
      }
    } else {
      final uncompletedStep = userStatus.uncompletedStep;
      if (uncompletedStep != null &&
          !path.startsWith(InitialProfileRoutes.main.fullPath)) {
        return uncompletedStep
            .navigationFromBasePath(InitialProfileRoutes.main.fullPath);
      }
    }
    return null;
  },
  routes: [
    GoRoute(
        path: homeRoute,
        redirect: (context, state) {
          final path = state.fullPath;
          if (path == homeRoute) {
            return BottomNavigation.main.fullPath;
          }
          return null;
        },
        routes: [
          GoRoute(
              path: MainRoutes.messages.path,
              redirect: (context, state) {
                final chatId =
                    state.pathParameters[MainRoutes.messages.pathParameter];
                if (chatId == null || chatId == "") {
                  return BottomNavigation.chat.fullPath;
                }
                return null;
              },
              builder: (context, state) {
                final chatId =
                    state.pathParameters[MainRoutes.messages.pathParameter];
                return MessageListScreen(
                    chatId: chatId!,
                    chatService: getIt(),
                    profileService: getIt());
              }),
          bottomNavigation,
          authRoutes,
          initialProfileRoutes
        ]),
  ],
);
