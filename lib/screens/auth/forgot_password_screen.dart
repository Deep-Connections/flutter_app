import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/injectable.dart';
import '../components/form/button_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _auth = getIt<AuthService>();
  final email = EmailInput();
  late final buttonInput = ButtonInput(fields: [email]);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.forgotPassword_title,
      body: DcColumn(children: [
        Text(loc.forgotPassword_infoText),
        Form(
            key: buttonInput.formKey,
            child: DcTextFormField(fieldInput: email)),
        FormButton(
            text: loc.forgotPassword_resetButton,
            buttonInput: buttonInput,
            actionIfValid: () async {
              _auth.sendPasswordResetEmail(email: email.value);
            })
      ]),
    );
  }
}
