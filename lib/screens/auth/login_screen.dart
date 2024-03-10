import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:deep_connections/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/constants.dart';
import '../components/form/dc_text_form_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final void Function() navigateRegister;
  final AuthService auth;

  const LoginScreen(
      {super.key, required this.navigateRegister, required this.auth});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = EmailInput();
  final password = PasswordInput();
  late final buttonInput = ButtonInput(fields: [email, password]);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.login_title,
      actions: [
        TextButton.icon(
            onPressed: widget.navigateRegister,
            icon: const Icon(Icons.person),
            label: Text(loc.login_registerLink))
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
              text: loc.login_loginButton,
              buttonInput: buttonInput,
              actionIfValid: () async {
                widget.auth.loginWithEmail(
                    email: email.value, password: password.value);
              },
            ),
            TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen())),
                child: Text(loc.login_forgotPasswordLink)),
          ],
        ),
      ),
    );
  }
}
