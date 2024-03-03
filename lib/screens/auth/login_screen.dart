import 'package:deep_connections/services/auth.dart';
import 'package:deep_connections/screens/components/BaseScreen.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';

class LoginScreen extends StatefulWidget {
  final Function navigateRegister;
  const LoginScreen({super.key, required this.navigateRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Sign in to $APP_NAME',
      actions: [
        TextButton.icon(
            onPressed: () {
              widget.navigateRegister();
            },
            icon: const Icon(Icons.person),
            label: const Text("Register"))
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
                  child: const Text("Sign in"),
                  onPressed: () async {
                    _auth.loginWithEmail(email: email, password: password);
                  },
                )
              ],
            ),
          )),
    );
  }
}
