import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../../config/injectable.dart';

class Home extends StatelessWidget {
  final VoidCallback navigateCallback;

  Home({super.key, required this.navigateCallback});

  final AuthService _auth = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Home",
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        body: ElevatedButton(
            onPressed: navigateCallback, child: const Text("create route")));
  }
}
