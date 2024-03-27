import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../config/constants.dart';
import '../../services/auth/auth_service.dart';
import '../components/form/dc_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  final AuthService auth;
  final VoidCallback onLoginSuccess;

  const LoginScreen(
      {super.key, required this.auth, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = EmailInput();
  final password = PasswordInput();
  late final buttonInput = ButtonInput(fields: [email, password]);
  String? apiError;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.login_title,
      actions: [
        TextButton.icon(
            onPressed: () => context.go(AuthRoutes.register.fullPath),
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
              error: apiError,
            ),
            FormButton(
              text: loc.login_loginButton,
              buttonInput: buttonInput,
              actionIfValid: () async {
                final response = await widget.auth.loginWithEmail(
                    email: email.value, password: password.value);
                response.onSuccess((_) => widget.onLoginSuccess());
                setState(() {
                  apiError = response.getUiErrOrNull(loc);
                });
              },
            ),
            TextButton(
                onPressed: () {
                  context.go(AuthRoutes.forgotPassword.fullPath);
                },
                child: Text(loc.login_forgotPasswordLink)),
          ],
        ),
      ),
    );
  }
}
