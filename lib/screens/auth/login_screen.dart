import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/services/auth.dart';
import 'package:deep_connections/services/error_handling.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../components/form/dc_text_form_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final void Function() navigateRegister;

  const LoginScreen({super.key, required this.navigateRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final email = EmailInput();
  final password = PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Sign in to $APP_NAME',
      actions: [
        TextButton.icon(
            onPressed: widget.navigateRegister,
            icon: const Icon(Icons.person),
            label: const Text("Register"))
      ],
      body: Form(
        key: _formKey,
        child: DcColumn(
          children: [
            const SizedBox(height: BASE_PADDING),
            DcTextFormField(fieldInput: email),
            DcTextFormField(
              fieldInput: password,
              textInputAction: TextInputAction.done,
            ),
            ElevatedButton(
              child: const Text("Sign in"),
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  _auth.loginWithEmail(
                      email: email.value, password: password.value);
                }
              },
            ),
            TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen())),
                child: const Text("Forgot password?")),
            ElevatedButton(
              child: const Text("Test Error"),
              onPressed: () async {
                MessageHandler.showError("message");
              },
            ),
          ],
        ),
      ),
    );
  }
}
