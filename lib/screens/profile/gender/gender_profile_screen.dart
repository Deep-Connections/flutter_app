import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:deep_connections/screens/profile/future_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender/gender_more_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final Future<void> Function() navigateToNext;

  const GenderProfileScreen(
      {super.key, required this.profileService, required this.navigateToNext});

  @override
  State<GenderProfileScreen> createState() => _GenderProfileScreenState();
}

class _GenderProfileScreenState extends State<GenderProfileScreen> {
  final gender = SingleGenderInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureFieldProfileScreen(
      title: loc.profile_genderTitle,
      profileService: widget.profileService,
      fields: [gender],
      builder: (BuildContext context, Profile profile) {
        gender.value = profile.gender;
        return DcListView(children: [
          ...Gender.base
              .map((g) => GenderButton(gender: g, genderInput: gender)),
          MoreGenderButton(
            genderInput: gender,
            onPressed: () {
              // todo move navigation to go router
              context.navigate(GenderMoreScreen(genderInput: gender));
            },
          ),
        ]);
      },
      onNext: () async {
        widget.profileService
            .updateProfile((p) => p.copyWith(gender: gender.value));
        await widget.navigateToNext();
      },
    );
  }
}
