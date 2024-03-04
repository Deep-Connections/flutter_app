import 'package:deep_connections/screens/components/BaseScreen.dart';
import 'package:deep_connections/screens/components/form/FieldInput.dart';
import 'package:deep_connections/services/auth.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../components/form/DcTextFormField.dart';

class LoginScreen extends StatefulWidget {
  final Function navigateRegister;

  const LoginScreen({super.key, required this.navigateRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final email = EmailInput();
  var password = PasswordInput();

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
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                DcTextFormField(
                  fieldInput: email,
                ),
                const SizedBox(height: 20.0),
                DcTextFormField(
                  fieldInput: password,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  child: const Text("Sign in"),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      _auth.loginWithEmail(
                          email: email.value, password: password.value);
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
