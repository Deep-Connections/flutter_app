import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/field_input/text_field_input.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/form/input_text_form_field.dart';

class NameProfileScreen extends StatefulWidget {
  final Stream<Profile?> profileStream;
  final Future<Response<void>> Function(
      Profile Function(Profile profile) transform) updateProfile;
  final LocKey submitText;

  const NameProfileScreen({
    super.key,
    required this.profileStream,
    required this.updateProfile,
    required this.submitText,
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
      profileStream: widget.profileStream,
      title: loc.completeProfile_firstNameTitle,
      submitText: widget.submitText.localize(loc),
      builder: (BuildContext context, Profile profile) {
        name.value = profile.firstName;
        return DcListView(
          children: [
            InputTextFormField(
                fieldInput: name, textInputAction: TextInputAction.done)
          ],
        );
      },
      fields: [name],
      onSubmit: () async {
        await widget.updateProfile((p) => p.copyWith(firstName: name.value));
      },
    );
  }
}
