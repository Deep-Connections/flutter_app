import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/screens/profile/BaseProfileScreen.dart';
import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/button_input.dart';
import '../components/form/dc_text_form_field.dart';

class NameProfileScreen extends StatefulWidget {
  final FirebaseProfileService profileService;

  const NameProfileScreen({super.key, required this.profileService});

  @override
  State<NameProfileScreen> createState() => _NameProfileScreenState();
}

class _NameProfileScreenState extends State<NameProfileScreen> {
  final name = FirstNameInput();
  late final buttonInput = ButtonInput(fields: [name]);

  @override
  void initState() {
    super.initState();
    widget.profileService.profile.then((value) {
      name.value = value?.firstName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileBaseScreen(
      title: loc.profile_firstNameTitle,
      fields: [name],
      onNext: () async {
        final response = await widget.profileService.updateProfile((p) => p);
      },
      children: [
        DcTextFormField(fieldInput: name, textInputAction: TextInputAction.done)
      ],
    );
  }
}
