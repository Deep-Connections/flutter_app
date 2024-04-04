import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/components/form/field_input/text_field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/constants.dart';
import '../../services/auth/auth_service.dart';
import '../components/form/button_input.dart';

class RegistrationScreen extends StatefulWidget {
  final AuthService auth;

  const RegistrationScreen({super.key, required this.auth});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final email = EmailInput();
  final password = PasswordInput();
  late final buttonInput = ButtonInput(fields: [email, password]);
  String? apiError;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
      title: loc.register_title,
      showBackButton: false,
      actions: [
        TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.person),
            label: Text(loc.register_loginLink))
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
                error: apiError),
            FormButton(
                text: loc.register_registerButton,
                buttonInput: buttonInput,
                actionIfValid: () async {
                  final response = await widget.auth.registerWithEmail(
                      email: email.value, password: password.value);
                  setState(() {
                    apiError = response.getUiErrOrNull(loc);
                  });
                })
          ],
        ),
      ),
    );
  }
}
