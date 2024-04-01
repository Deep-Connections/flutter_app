import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/screens/profile/BaseProfileScreen.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/dc_text_form_field.dart';

class GenderProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final VoidCallback navigateToNext;

  const GenderProfileScreen(
      {super.key, required this.profileService, required this.navigateToNext});

  @override
  State<GenderProfileScreen> createState() => _GenderProfileScreenState();
}

class _GenderProfileScreenState extends State<GenderProfileScreen> {
  final gender = GenderInput();

  @override
  void initState() {
    super.initState();
    widget.profileService.profile.then((value) {
      gender.value = value?.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
      title: loc.profile_genderTitle,
      fields: [gender],
      children: [
        ...Gender.values
            .map((g) => GenderButton(gender: g, genderInput: gender)),
        DcTextFormField(
            fieldInput: gender, textInputAction: TextInputAction.done),
      ],
      onNext: () async {
        final response = await widget.profileService
            .updateProfile((p) => p.copyWith(gender: gender.value));
        response.onSuccess((_) => widget.navigateToNext());
      },
    );
  }
}
