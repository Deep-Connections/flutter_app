import 'package:deep_connections/navigation/auth_navigation.dart';
import 'package:deep_connections/navigation/profile_navigation.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable.dart';
import '../screens/home/home.dart';
import '../services/user/user_service.dart';

final appRouter = GoRouter(
  initialLocation: AuthRoutes.main.path,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: HomeRoutes.home.path,
      redirect: (BuildContext context, GoRouterState state) {
        final userState = getIt<UserService>().userState;
        if (!userState.isAuthenticated) {
          return AuthRoutes.main.fullPath;
        }
        if (!userState.isProfileComplete) {
          return ProfileRoutes.main.fullPath;
        }
        return null;
      },
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
