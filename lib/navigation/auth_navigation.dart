import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/services/user/user_status.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable/injectable.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/registration_screen.dart';

final authRoutes = GoRoute(
  path: AuthRoutes.main.path,
  redirect: (context, state) {
    final UserStatus userStatus = getIt<UserStatusService>().userStatus;
    if (userStatus.isAuthenticated) {
      return userStatus.unCompletedStep
              ?.navigationFromBasePath(ProfileRoutes.main.path) ??
          HomeRoutes.home.fullPath;
    }
    if (state.fullPath == AuthRoutes.main.path) {
      return AuthRoutes.login.fullPath;
    }
    return null;
  },
  routes: [
    GoRoute(
        path: AuthRoutes.login.path,
        builder: (context, state) {
          return LoginScreen(
              auth: getIt(), onLoginSuccess: () {});
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
