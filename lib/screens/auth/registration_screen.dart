import 'package:deep_connections/services/auth.dart';
import 'package:deep_connections/screens/components/BaseScreen.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';

class RegistrationScreen extends StatefulWidget {
  final Function navigateLogin;

  const RegistrationScreen({super.key, required this.navigateLogin});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Sign up to $APP_NAME',
      actions: [
        TextButton.icon(
            onPressed: () {
              widget.navigateLogin();
            },
            icon: const Icon(Icons.person),
            label: const Text("Sign in"))
      ],
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () async {
                    _auth.registerWithEmail(email: email, password: password);
                  },
                )
              ],
            ),
          )),
    );
  }
}
