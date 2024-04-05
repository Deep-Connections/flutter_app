import 'package:deep_connections/screens/components/form/field_input/date_field_input.dart';
import 'package:deep_connections/screens/profile/profile_base_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/dc_text_form_field.dart';

class BirthdayProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final VoidCallback navigateToNext;

  const BirthdayProfileScreen(
      {super.key, required this.profileService, required this.navigateToNext});

  @override
  State<BirthdayProfileScreen> createState() => _BirthdayProfileScreenState();
}

class _BirthdayProfileScreenState extends State<BirthdayProfileScreen> {
  final birthdate = BirthdayInput();

  @override
  void initState() {
    super.initState();
    widget.profileService.profile.then((value) {
      birthdate.value = value.birthdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
      title: loc.profile_birthdayTitle,
      fields: [birthdate],
      onNext: () async {
        final response = await widget.profileService
            .updateProfile((p) => p.copyWith(birthdate: birthdate.value));
        response.onSuccess((_) => widget.navigateToNext());
      },
      children: [
        DcTextFormField(
            fieldInput: birthdate, textInputAction: TextInputAction.done)
      ],
    );
  }
}
