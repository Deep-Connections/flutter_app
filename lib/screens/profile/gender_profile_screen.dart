import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/constants.dart';
import '../components/base_screen.dart';
import '../components/form/button_input.dart';
import '../components/form/dc_text_form_field.dart';
import '../components/form/form_button.dart';

class GenderProfileScreen extends StatefulWidget {
  final FirebaseProfileService profileService;

  const GenderProfileScreen({super.key, required this.profileService});

  @override
  State<GenderProfileScreen> createState() => _GenderProfileScreenState();
}

class _GenderProfileScreenState extends State<GenderProfileScreen> {
  final gender = GenderInput();
  late final buttonInput = ButtonInput(fields: [gender]);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.profile_sizeTitle,
        body: Form(
          key: buttonInput.formKey,
          child: DcColumn(
            children: [
              const SizedBox(height: BASE_PADDING),
              DcTextFormField(
                  fieldInput: gender, textInputAction: TextInputAction.done),
              FormButton(
                text: loc.general_submitButton,
                buttonInput: buttonInput,
                actionIfValid: () async {
                  final response = await widget.profileService
                      .updateProfile((p) => p.copyWith(gender: gender.value));
                },
              ),
            ],
          ),
        ));
  }
}
