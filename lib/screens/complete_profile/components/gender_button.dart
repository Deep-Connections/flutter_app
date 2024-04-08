import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/components/form/field_input/gender_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          text: gender.localize(loc),
          onPressed: () => genderInput.clickOnGender(gender),
          selected: genderInput.isSelected(gender),
          enabled: genderInput.enabled,
        );
      },
    );
  }
}

class MoreGenderButton extends StatelessWidget {
  final GenderInput genderInput;
  final VoidCallback onPressed;

  const MoreGenderButton(
      {super.key, required this.genderInput, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: genderInput,
      builder: (context, child) {
        final text = genderInput.moreText(loc);
        final isSelected = text != null;
        return SelectableButton(
            text: text ?? loc.completeProfile_genderMore,
            onPressed: onPressed,
            selected: isSelected,
            enabled: genderInput.enabled,
            icon: Icon(Icons.arrow_right,
                color: Theme.of(context).colorScheme.outline)
            //icon: Text(" >", style: TextStyle(inherit: true, color: Theme.of(context).colorScheme.outline))
            );
      },
    );
  }
}

class SelectableButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool selected;
  final String text;
  final bool enabled;
  final Widget? icon;

  const SelectableButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.selected = false,
      this.enabled = true,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? null : unselectedColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30.0),
        //   side: selected
        //       ? const BorderSide(color: Color(0xFF81a87b))
        //       : BorderSide.none,
        // ),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Flexible(
            child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          semanticsLabel: selected ? loc.semantic_selected(text) : text,
        )),
        if (icon != null) icon!
      ]),
    );
  }
}
