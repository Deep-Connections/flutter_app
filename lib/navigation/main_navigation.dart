import 'package:deep_connections/navigation/auth_navigation.dart';
import 'package:deep_connections/navigation/profile_navigation.dart';
import 'package:deep_connections/navigation/refresh_listenable.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/services/user/user_status.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../screens/home/home.dart';
import '../services/user/user_service.dart';

final appRouter = GoRouter(
  refreshListenable:
      GoRouterRefreshListenable(getIt<UserService>().userStatusStream),
  initialLocation: AuthRoutes.main.path,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final UserStatus userStatus = getIt<UserService>().userStatus;
    final path = state.fullPath;
    if (path == null) return AuthRoutes.main.fullPath;
    if (!userStatus.isAuthenticated &&
        !path.startsWith(AuthRoutes.main.fullPath)) {
      return AuthRoutes.main.fullPath;
    }
    if (userStatus.isAuthenticated &&
        !userStatus.isProfileComplete &&
        !path.startsWith(ProfileRoutes.main.fullPath)) {
      return ProfileRoutes.main.fullPath;
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
