import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/components/gender_button.dart';
import 'package:deep_connections/screens/complete_profile/gender_preferences/gender_preferences_more_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderPreferencesProfileScreen extends StatefulWidget {
  final Stream<Profile?> profileStream;
  final Future<Response<void>> Function(
      Profile Function(Profile profile) transform) updateProfile;
  final LocKey submitText;

  const GenderPreferencesProfileScreen(
      {super.key,
      required this.profileStream,
      required this.updateProfile,
      required this.submitText});

  @override
  State<GenderPreferencesProfileScreen> createState() =>
      _GenderProfileScreenState();
}

class _GenderProfileScreenState extends State<GenderPreferencesProfileScreen> {
  final genderInput = MultipleGenderInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureFieldProfileScreen(
      title: loc.completeProfile_genderPreferencesTitle,
      submitText: widget.submitText.localize(loc),
      profileStream: widget.profileStream,
      builder: (BuildContext context, Profile profile) {
        genderInput.value = profile.genderPreferences;
        return DcListView(children: [
          ...Gender.base
              .map((g) => GenderButton(gender: g, genderInput: genderInput)),
          MoreGenderButton(
            genderInput: genderInput,
            onPressed: () => context.navigate(
                GenderPreferencesMoreProfileScreen(genderInput: genderInput)),
          ),
          GenderButton(gender: Gender.everyone, genderInput: genderInput)
        ]);
      },
      onSubmit: () async => await widget.updateProfile(
          (p) => p.copyWith(genderPreferences: genderInput.value)),
    );
  }
}
