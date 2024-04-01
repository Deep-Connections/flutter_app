import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:deep_connections/screens/profile/gender/gender_more_screen.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderButton extends StatelessWidget {
  final Gender gender;
  final SingleGenderInput genderInput;

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
  final SingleGenderInput genderInput;

  const GenderTypeInButton({super.key, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: genderInput,
      builder: (context, child) {
        return ValueListenableBuilder(
            valueListenable: genderInput.controller,
            builder: (context, typedGenderText, child) {
              var text = "";
              if (genderInput.selectedGender == null) {
                text = typedGenderText.text;
              }
              final additionalGender = Gender.additional
                  .firstWhereOrNull((g) => g == genderInput.selectedGender);
              if (additionalGender != null) {
                text = additionalGender.localizedName.localize(loc);
              }
              final isSelected = text.isNotEmpty;
              if (text.isEmpty) text = loc.profile_genderMore;
              return SelectableButton(
                text: "$text >",
                onPressed: () {
                  // todo move navigation to go router
                  context.navigate(GenderMoreScreen(genderInput: genderInput));
                },
                selected: isSelected,
                enabled: genderInput.enabled,
              );
            });
      },
    );
  }
}

class MultipleGenderButton extends StatelessWidget {
  final Gender gender;
  final MultipleGenderInput genderInput;

  const MultipleGenderButton(
      {super.key, required this.gender, required this.genderInput});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListenableBuilder(
        listenable: genderInput,
        builder: (context, child) {
          return SelectableButton(
              text: gender.localizedName.localize(loc),
              onPressed: () => genderInput.toggleGender(gender),
              selected: genderInput.selectedGenders.contains(gender),
              enabled: genderInput.enabled);
        });
  }
}

class SelectableButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool selected;
  final String text;
  final bool enabled;

  const SelectableButton(
      {super.key,
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
