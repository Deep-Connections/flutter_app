import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/constants.dart';
import '../components/base_screen.dart';
import '../components/form/button_input.dart';
import '../components/form/dc_text_form_field.dart';
import '../components/form/form_button.dart';

class HeightProfileScreen extends StatefulWidget {
  const HeightProfileScreen({super.key});

  @override
  State<HeightProfileScreen> createState() => _HeightProfileScreenState();
}

class _HeightProfileScreenState extends State<HeightProfileScreen> {
  final height = HeightInput();
  late final buttonInput = ButtonInput(fields: [height]);
  String? apiError;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.profile_sizeTitle,
        body: Form(
          key: buttonInput.formKey,
          child: DcColumn(
            children: [
              const SizedBox(height: BASE_PADDING),
              DcTextFormField(
                  fieldInput: height,
                  textInputAction: TextInputAction.done,
                  error: apiError),
              FormButton(
                text: loc.general_submitButton,
                buttonInput: buttonInput,
                actionIfValid: () async {
                  /*final response = await widget.auth.loginWithEmail(
                      email: height.value, password: password.value);
                  setState(() {
                    apiError = response.getUiErrOrNull(loc);
                  });*/
                },
              ),
            ],
          ),
        ));
  }
}
