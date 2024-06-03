import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/date_field_input.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/input_text_form_field.dart';

class BirthdayProfileScreen extends StatefulWidget {
  final Stream<Profile?> profileStream;
  final Future<Response<void>> Function(
      Profile Function(Profile profile) transform) updateProfile;
  final LocKey submitText;

  const BirthdayProfileScreen(
      {super.key,
      required this.profileStream,
      required this.updateProfile,
      required this.submitText});

  @override
  State<BirthdayProfileScreen> createState() => _BirthdayProfileScreenState();
}

class _BirthdayProfileScreenState extends State<BirthdayProfileScreen> {
  final dateOfBirth = BirthdayInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureFieldProfileScreen(
        title: loc.completeProfile_birthdayTitle,
        profileStream: widget.profileStream,
        fields: [dateOfBirth],
        submitText: widget.submitText.localize(loc),
        onSubmit: () async => await widget
            .updateProfile((p) => p.copyWith(dateOfBirth: dateOfBirth.value)),
        builder: (BuildContext context, Profile profile) {
          dateOfBirth.setWithContext(context, profile.dateOfBirth);
          return DcListView(
            children: [
              InputTextFormField(
                  fieldInput: dateOfBirth,
                  textInputAction: TextInputAction.done),
            ],
          );
        });
  }
}
