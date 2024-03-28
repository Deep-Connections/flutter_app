import 'package:deep_connections/models/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/form/field_input.dart';

class GenderButton extends StatelessWidget {
  final Gender gender;
  final GenderInput genderInput;

  const GenderButton(
      {super.key, required this.gender, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return ValueListenableBuilder(
      valueListenable: genderInput.controller,
      builder: (context, genderValue, child) {
        final border = genderValue.text == gender.enumValue
            ? const BorderSide(color: Colors.black)
            : BorderSide.none;

        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: border,
              ),
            ),
          ),
          onPressed: () => genderInput.value = gender.enumValue,
          child: Text(gender.localizedName.localize(loc)),
        );
      },
    );
  }
}
