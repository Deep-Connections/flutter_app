import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:deep_connections/screens/profile/gender_preferences/gender_preferences_more_screen.dart';
import 'package:deep_connections/screens/profile/profile_base_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderPreferencesProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final VoidCallback navigateToNext;

  const GenderPreferencesProfileScreen(
      {super.key, required this.profileService, required this.navigateToNext});

  @override
  State<GenderPreferencesProfileScreen> createState() =>
      _GenderProfileScreenState();
}

class _GenderProfileScreenState extends State<GenderPreferencesProfileScreen> {
  final genderInput = MultipleGenderInput();

  @override
  void initState() {
    super.initState();
    widget.profileService.profile.then((value) {
      genderInput.value = value?.genderPreferences;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
      title: loc.profile_genderPreferencesTitle,
      children: [
        ...Gender.base
            .map((g) => GenderButton(gender: g, genderInput: genderInput)),
        MoreGenderButton(
          genderInput: genderInput,
          onPressed: () => context.navigate(
              GenderPreferencesMoreProfileScreen(genderInput: genderInput)),
        ),
        GenderButton(gender: Gender.everyone, genderInput: genderInput)
      ],
      onNext: () async {
        final response = await widget.profileService.updateProfile(
            (p) => p.copyWith(genderPreferences: genderInput.value));
        response.onSuccess((_) => widget.navigateToNext());
      },
    );
  }
}
