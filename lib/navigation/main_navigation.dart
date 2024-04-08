import 'package:deep_connections/models/user/user_status.dart';
import 'package:deep_connections/navigation/auth_navigation.dart';
import 'package:deep_connections/navigation/profile_navigation.dart';
import 'package:deep_connections/navigation/refresh_listenable.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../screens/home/home.dart';

final appRouter = GoRouter(
  refreshListenable:
      GoRouterRefreshListenable(getIt<UserStatusService>().userStatusStream),
  initialLocation: AuthRoutes.main.path,
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
          !path.startsWith(CompleteProfileRoutes.main.fullPath)) {
        return uncompletedStep
            .navigationFromBasePath(CompleteProfileRoutes.main.path);
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: HomeRoutes.home.path,
      builder: (context, state) {
        return Home(
          navigateCallback: () => context.go(HomeRoutes.home.fullPath),
        );
      },
    ),
    authRoutes,
    profileRoutes,
  ],
);
