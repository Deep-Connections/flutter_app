import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/form/field_input/text_field_input.dart';
import 'package:deep_connections/screens/profile/future_profile_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/dc_text_form_field.dart';

class NameProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final VoidCallback navigateToNext;

  const NameProfileScreen({
    super.key,
    required this.profileService,
    required this.navigateToNext,
  });

  @override
  State<NameProfileScreen> createState() => _NameProfileScreenState();
}

class _NameProfileScreenState extends State<NameProfileScreen> {
  final name = FirstNameInput();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return FutureFieldProfileScreen(
      profileService: widget.profileService,
      title: loc.profile_firstNameTitle,
      builder: (BuildContext context, Profile profile) {
        name.value = profile.firstName;
        return ListView(
          children: [
            DcTextFormField(
                fieldInput: name, textInputAction: TextInputAction.done)
          ],
        );
      },
      fields: [name],
      onNext: () async {
        widget.profileService
            .updateProfile((p) => p.copyWith(firstName: name.value));
        widget.navigateToNext();
      },
    );
  }
}
