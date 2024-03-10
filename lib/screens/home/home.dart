import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../../config/injectable.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Home",
        body: ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: const Text("logout")));
  }
}
