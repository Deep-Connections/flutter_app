import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/complete_profile/components/base_gender_more_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/components/form/dc_text_form_field.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/gender.dart';
import '../../components/form/button_input.dart';
import '../components/gender_button.dart';

class GenderMoreScreen extends StatefulWidget {
  final SingleGenderInput genderInput;

  GenderMoreScreen({super.key, required this.genderInput});

  late final buttonInput = ButtonInput(fields: [genderInput]);

  @override
  State<GenderMoreScreen> createState() => _GenderMoreScreenState();
}

class _GenderMoreScreenState extends State<GenderMoreScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseGenderMoreScreen(
      body: DcListView(children: [
        ...Gender.additional.map(
            (g) => GenderButton(gender: g, genderInput: widget.genderInput)),
        Container(padding: const EdgeInsets.only(top: standardPadding)),
        Text(loc.completeProfile_genderMoreTypeIn,
            style: Theme.of(context).textTheme.bodyLarge),
        Form(
          key: widget.buttonInput.formKey,
          child: DcTextFormField(
              fieldInput: widget.genderInput,
              textInputAction: TextInputAction.done),
        )
      ]),
      bottom: FormButton(
          text: loc.general_submitButton,
          buttonInput: widget.buttonInput,
          actionIfValid: () async => Navigator.of(context).pop()),
    );
  }
}
