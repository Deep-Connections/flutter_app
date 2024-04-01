import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/profile/profile_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/gender.dart';
import '../components/gender_button.dart';

class GenderMoreScreen extends StatelessWidget {
  final SingleGenderInput genderInput;

  const GenderMoreScreen({super.key, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
        title: loc.profile_genderMoreTitle,
        fields: [genderInput],
        nextButtonText: loc.general_submitButton,
        children: [
          ...Gender.additional
              .map((g) => GenderButton(gender: g, genderInput: genderInput)),
          DcTextFormField(
              fieldInput: genderInput, textInputAction: TextInputAction.done),
        ],
        onNext: () async => Navigator.of(context).pop());
  }
}
