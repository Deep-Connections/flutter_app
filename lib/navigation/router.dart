import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/auth/registration_screen.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home.dart';

final appRouter = GoRouter(
  initialLocation: AuthRoutes.login.path,
  debugLogDiagnostics: true,
  redirect: (context, GoRouterState state) {
    final currentPath = state.fullPath;
    if (currentPath == null) return null;
    final topPath = "/${currentPath.split("/")[1]}";

    // if the user is not logged in, they need to login
    final loggedIn = getIt<UserService>().isLoggedIn;
    final loggingIn = topPath == AuthRoutes.login.path;
    if (!loggedIn && !loggingIn) return AuthRoutes.login.link;
    if (loggedIn && loggingIn) return HomeRoutes.home.link;

    return null;
  },
  routes: [
    GoRoute(
      path: AuthRoutes.login.path,
      builder: (context, state) {
        return LoginScreen(auth: getIt());
      },
      routes: [
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
    ),
    GoRoute(
      path: HomeRoutes.home.path,
      builder: (context, state) {
        return Home(
          navigateCallback: () => context.go(HomeRoutes.home.link),
        );
      },
    ),
  ],
);
