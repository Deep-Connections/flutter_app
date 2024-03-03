import 'package:deep_connections/services/auth.dart';
import 'package:deep_connections/screens/components/BaseScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

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
