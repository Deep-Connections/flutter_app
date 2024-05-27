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
            trailing: Icon(Icons.arrow_right,
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
  final Widget? trailing;

  SelectableButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.selected = false,
      this.enabled = true,
      this.trailing})
      : super(key: key ?? ValueKey(text));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? colorScheme.primary : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*selected
                ? const Row(
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      SizedBox(width: standardPadding / 2)
                    ],
                  )
                : Container(),*/
            Flexible(
              child: Text(
                text,
                style: theme.textTheme.headlineSmall?.copyWith(
                    color: selected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface),
                textAlign: TextAlign.center,
                semanticsLabel: selected ? loc.semantic_selected(text) : text,
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
    // previous implementations
    /*return ChoiceChip(
      selectedColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      label: Flexible(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
      selected: selected,
      onSelected: enabled ? (_) => onPressed?.call() : null,
    );
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : Colors.grey,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(standardPadding),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? null : DcColors.grey,
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
    );*/
  }
}
