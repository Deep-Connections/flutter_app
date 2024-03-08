import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:deep_connections/services/auth.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../components/form/button_input.dart';
import '../components/form/field_input.dart';

class RegistrationScreen extends StatefulWidget {
  final void Function() navigateLogin;

  const RegistrationScreen({super.key, required this.navigateLogin});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthService _auth = AuthService();

  final email = EmailInput();
  final password = PasswordInput();
  late final buttonInput = ButtonInput(fields: [email, password]);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Sign up to $APP_NAME',
      actions: [
        TextButton.icon(
            onPressed: widget.navigateLogin,
            icon: const Icon(Icons.person),
            label: const Text("Sign in"))
      ],
      body: Form(
        key: buttonInput.formKey,
        child: DcColumn(
          children: [
            const SizedBox(height: BASE_PADDING),
            DcTextFormField(fieldInput: email),
            DcTextFormField(
              fieldInput: password,
              textInputAction: TextInputAction.done,
            ),
            FormButton(
                text: "Register",
                buttonInput: buttonInput,
                action: () async {
                  _auth.registerWithEmail(
                      email: email.value, password: password.value);
                })
          ],
        ),
      ),
    );
  }
}
