import 'package:deep_connections/screens/components/form/field_input/text_field_input.dart';
import 'package:deep_connections/screens/profile/profile_base_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/dc_text_form_field.dart';

class NameProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final VoidCallback navigateToNext;

  const NameProfileScreen(
      {super.key, required this.profileService, required this.navigateToNext});

  @override
  State<NameProfileScreen> createState() => _NameProfileScreenState();
}

class _NameProfileScreenState extends State<NameProfileScreen> {
  final name = FirstNameInput();

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
        final response = await widget.profileService
            .updateProfile((p) => p.copyWith(firstName: name.value));
        response.onSuccess((_) => widget.navigateToNext());
      },
      children: [
        DcTextFormField(fieldInput: name, textInputAction: TextInputAction.done)
      ],
    );
  }
}
