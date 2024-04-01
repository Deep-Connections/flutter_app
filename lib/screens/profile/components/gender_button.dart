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
      valueListenable: genderInput.selectedGender,
      builder: (context, selectedGender, child) {
        return SelectableButton(
            text: gender.localizedName.localize(loc),
            onPressed: () => genderInput.selectedGender.value,
            selected: selectedGender == gender);
      },
    );
  }
}

class SelectableButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool selected;
  final String text;

  const SelectableButton(
      {super.key, required this.text, this.onPressed, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: selected
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
