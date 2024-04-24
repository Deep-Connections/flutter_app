import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/field_input/text_field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:deep_connections/screens/components/form/input_text_form_field.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/injectable/injectable.dart';
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
  var isSuccess = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final textTheme = Theme.of(context);
    return BaseScreen(
      title: loc.forgotPassword_title,
      body: !isSuccess
          ? DcColumn(children: [
              Text(loc.forgotPassword_infoText),
              Form(
                  key: buttonInput.formKey,
                  child: InputTextFormField(fieldInput: email)),
              FormButton(
                  text: loc.forgotPassword_resetButton,
                  buttonInput: buttonInput,
                  actionIfValid: () async {
                    final response =
                        await _auth.sendPasswordResetEmail(email: email.value);
                    response.onSuccess(
                        (result) => setState(() => isSuccess = true));
                    MessageHandler.showResponseError(response, loc);
                  })
            ])
          : DcColumn(
              children: [
                Text(loc.forgotPassword_success,
                    style: textTheme.textTheme.headlineLarge
                        ?.copyWith(color: textTheme.colorScheme.primary)),
                Text(
                  loc.forgotPassword_successText,
                  style: textTheme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
