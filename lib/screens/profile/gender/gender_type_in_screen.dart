import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/profile/profile_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/form/field_input.dart';

class GenderTypeInScreen extends StatelessWidget {
  final GenderInput genderInput;

  const GenderTypeInScreen({super.key, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
        title: loc.profile_genderTypeInTitle,
        fields: [genderInput],
        onNext: () async {
          genderInput.value = genderInput.controller.text;
          Navigator.of(context).pop();
        },
        nextButtonText: loc.general_submitButton,
        children: [
          DcTextFormField(
              fieldInput: genderInput, textInputAction: TextInputAction.done),
        ]);
  }
}
