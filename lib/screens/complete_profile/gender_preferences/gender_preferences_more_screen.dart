import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/components/gender_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderPreferencesMoreProfileScreen extends StatelessWidget {
  final GenderInput genderInput;

  const GenderPreferencesMoreProfileScreen(
      {super.key, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseProfileScreen(
        title: loc.completeProfile_genderPreferencesMoreTitle,
        bottom: ElevatedButton(
          child: Text(loc.general_submitButton),
          onPressed: () async => Navigator.of(context).pop(),
        ),
        child: DcListView(
          children: [
            ...Gender.additional
                .map((g) => GenderButton(gender: g, genderInput: genderInput))
          ],
        ));
  }
}
