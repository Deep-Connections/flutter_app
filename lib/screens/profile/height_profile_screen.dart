import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/form/field_input/integer_field_input.dart';
import 'package:deep_connections/screens/profile/future_profile_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/button_input.dart';
import '../components/form/dc_text_form_field.dart';

class HeightProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final void Function() navigateToNext;

  const HeightProfileScreen(
      {super.key, required this.profileService, required this.navigateToNext});

  @override
  State<HeightProfileScreen> createState() => _HeightProfileScreenState();
}

class _HeightProfileScreenState extends State<HeightProfileScreen> {
  final height = HeightInput();
  late final buttonInput = ButtonInput(fields: [height]);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return FutureFieldProfileScreen(
        profileService: widget.profileService,
        fields: [height],
        title: loc.profile_sizeTitle,
        builder: (BuildContext context, Profile profile) {
          height.value = profile.height;
          return ListView(children: [
            DcTextFormField(
              fieldInput: height,
              textInputAction: TextInputAction.done,
            )
          ]);
        },
        onNext: () async {
          widget.profileService
              .updateProfile((p) => p.copyWith(height: height.value));
          widget.navigateToNext();
        });
  }
}
