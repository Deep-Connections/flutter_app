import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/date_field_input.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/dc_text_form_field.dart';

class BirthdayProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final VoidCallback navigateToNext;
  final LocKey submitText;

  const BirthdayProfileScreen({super.key,
    required this.profileService,
    required this.navigateToNext,
    required this.submitText});

  @override
  State<BirthdayProfileScreen> createState() => _BirthdayProfileScreenState();
}

class _BirthdayProfileScreenState extends State<BirthdayProfileScreen> {
  final birthdate = BirthdayInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureFieldProfileScreen(
        title: loc.completeProfile_birthdayTitle,
        profileService: widget.profileService,
        fields: [birthdate],
        submitText: widget.submitText.localize(loc),
        onSubmit: () async {
          widget.profileService
              .updateProfile((p) => p.copyWith(birthdate: birthdate.value));
          widget.navigateToNext();
        },
        builder: (BuildContext context, Profile profile) {
          birthdate.setWithContext(context, profile.birthdate);
          return DcListView(
            children: [
              DcTextFormField(
                  fieldInput: birthdate, textInputAction: TextInputAction.done),
            ],
          );
        });
  }
}
