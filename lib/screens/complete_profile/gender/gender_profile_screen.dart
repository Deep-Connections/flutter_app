import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/components/gender_button.dart';
import 'package:deep_connections/screens/complete_profile/gender/gender_more_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final Future<void> Function() navigateToNext;
  final LocKey submitText;

  const GenderProfileScreen(
      {super.key,
      required this.profileService,
      required this.navigateToNext,
      required this.submitText});

  @override
  State<GenderProfileScreen> createState() => _GenderProfileScreenState();
}

class _GenderProfileScreenState extends State<GenderProfileScreen> {
  final genderInput = SingleGenderInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureFieldProfileScreen(
      title: loc.completeProfile_genderTitle,
      submitText: widget.submitText.localize(loc),
      profileService: widget.profileService,
      fields: [genderInput],
      builder: (BuildContext context, Profile profile) {
        genderInput.selectedGender = Gender.fromProfile(profile);
        return DcListView(children: [
          ...Gender.base
              .map((g) => GenderButton(gender: g, genderInput: genderInput)),
          MoreGenderButton(
            genderInput: genderInput,
            onPressed: () =>
                context.navigate(GenderMoreScreen(genderInput: genderInput)),
          ),
        ]);
      },
      onSubmit: () async {
        widget.profileService.updateProfile((p) {
          final gender = genderInput.selectedGender!;
          return p.copyWith(
              gender: gender.enumValue, customGender: gender.customName ?? "");
        });
        await widget.navigateToNext();
      },
    );
  }
}
