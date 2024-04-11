import 'dart:convert';

import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:deep_connections/screens/components/form/field_input/text_field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../config/constants.dart';
import '../../services/auth/auth_service.dart';
import '../components/form/dc_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  final AuthService auth;
  final Future Function() onLoginSuccess;

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

  loadDebugCredentials() async {
    if (kDebugMode) {
      try {
        final credentials =
            json.decode(await rootBundle.loadString('credentials.json'));
        email.value = credentials['email'];
        password.value = credentials['password'];
      } on AssertionError catch (_) {
        // ignore file not found
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadDebugCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.login_title,
      actions: [
        TextButton.icon(
            onPressed: () => context.push(AuthRoutes.register.fullPath),
            icon: const Icon(Icons.person),
            label: Text(loc.login_registerLink))
      ],
      body: Form(
        key: buttonInput.formKey,
        child: DcColumn(
          children: [
            const SizedBox(height: standardPadding),
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
                await response.onAwaitSuccess((_) => widget.onLoginSuccess());
                setState(() {
                  apiError = response.getUiErrOrNull(loc);
                });
              },
            ),
            TextButton(
                onPressed: () {
                  context.push(AuthRoutes.forgotPassword.fullPath);
                },
                child: Text(loc.login_forgotPasswordLink)),
          ],
        ),
      ),
    );
  }
}
