import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:deep_connections/screens/profile/profile_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderPreferencesMoreProfileScreen extends StatelessWidget {
  final GenderInput genderInput;

  const GenderPreferencesMoreProfileScreen(
      {super.key, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
        title: loc.profile_genderPreferencesMoreTitle,
        nextButtonText: loc.general_submitButton,
        children: [
          ...Gender.additional
              .map((g) => GenderButton(gender: g, genderInput: genderInput))
        ],
        onNext: () async => Navigator.of(context).pop());
  }
}
