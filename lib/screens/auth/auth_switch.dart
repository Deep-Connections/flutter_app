import 'package:deep_connections/screens/auth/login_screen.dart';
import 'package:deep_connections/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';

import '../../config/injectable.dart';
import '../../services/auth/auth_service.dart';

class AuthSwitch extends StatefulWidget {
  const AuthSwitch({super.key});

  @override
  State<AuthSwitch> createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {
  final auth = getIt<AuthService>();
  bool showSignIn = true;

  void switchView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(navigateRegister: switchView, auth: auth);
    } else {
      return RegistrationScreen(navigateLogin: switchView, auth: auth);
    }
  }
}
