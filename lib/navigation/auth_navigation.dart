import 'package:deep_connections/models/user/user_status.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/registration_screen.dart';

final authRoutes = GoRoute(
  path: AuthRoutes.main.path,
  redirect: (context, state) async {
    final UserStatus userStatus = await getIt<UserStatusService>().userStatus;
    if (userStatus.isAuthenticated) {
      return userStatus.uncompletedStep
              ?.navigationFromBasePath(CompleteProfileRoutes.main.fullPath) ??
          homeRoute;
    }
    if (state.fullPath == AuthRoutes.main.fullPath) {
      return AuthRoutes.login.fullPath;
    }
    return null;
  },
  routes: [
    GoRoute(
        path: AuthRoutes.login.path,
        builder: (context, state) {
          return LoginScreen(
              auth: getIt(),
              onLoginSuccess: () async {
                await getIt<UserStatusService>()
                    .userStatusStream
                    .firstWhere((userStatus) => userStatus.isAuthenticated);
              });
        }),
    GoRoute(
        path: AuthRoutes.register.path,
        builder: (context, state) {
          return RegistrationScreen(auth: getIt());
        }),
    GoRoute(
        path: AuthRoutes.forgotPassword.path,
        builder: (context, state) {
          return const ForgotPasswordScreen();
        }),
  ],
);
