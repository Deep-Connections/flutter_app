import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/integer_field_input.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/button_input.dart';
import '../components/form/input_text_form_field.dart';

class HeightProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final void Function() navigateToNext;
  final LocKey submitText;

  const HeightProfileScreen(
      {super.key,
      required this.profileService,
      required this.navigateToNext,
      required this.submitText});

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
        title: loc.completeProfile_sizeTitle,
        submitText: widget.submitText.localize(loc),
        builder: (BuildContext context, Profile profile) {
          height.value = profile.height;
          return DcListView(children: [
            InputTextFormField(
              fieldInput: height,
              textInputAction: TextInputAction.done,
            )
          ]);
        },
        onSubmit: () async {
          widget.profileService
              .updateProfile((p) => p.copyWith(height: height.value));
          widget.navigateToNext();
        });
  }
}
