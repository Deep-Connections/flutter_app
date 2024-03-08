import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../services/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final email = EmailInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.forgotPassword_title,
      body: DcColumn(children: [
        Text(loc.forgotPassword_infoText),
        DcTextFormField(fieldInput: email, key: _formKey),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() == true) {
              _auth.sendPasswordResetEmail(email: email.value);
            }
          },
          child: Text(loc.forgotPassword_resetButton),
        )
      ]),
    );
  }
}
