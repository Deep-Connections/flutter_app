import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/profile/gender/gender_type_in_screen.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
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

    return ListenableBuilder(
      listenable: genderInput,
      builder: (context, child) {
        return SelectableButton(
          text: gender.localizedName.localize(loc),
          onPressed: () => genderInput.selectedGender = gender,
          selected: genderInput.selectedGender == gender,
          enabled: genderInput.enabled,
        );
      },
    );
  }
}

class GenderTypeInButton extends StatelessWidget {
  final GenderInput genderInput;

  const GenderTypeInButton({super.key, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: genderInput,
      builder: (context, child) {
        return ValueListenableBuilder(
            valueListenable: genderInput.controller,
            builder: (context, genderText, child) {
              var text = genderText.text;
              if (text.isEmpty) text = loc.input_genderMore;
              final isSelected = genderInput.selectedGender == null;
              return SelectableButton(
                text: text,
                onPressed: () {
                  if (!isSelected && genderInput.controller.text.isNotEmpty) {
                    genderInput.selectedGender = null;
                  } else {
                    // todo move navigation to go router
                    context
                        .navigate(GenderTypeInScreen(genderInput: genderInput));
                  }
                },
                selected: isSelected,
                enabled: genderInput.enabled,
              );
            });
      },
    );
  }
}

class SelectableButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool selected;
  final String text;
  final bool enabled;

  const SelectableButton({super.key,
    required this.text,
    this.onPressed,
    this.selected = false,
    this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
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
