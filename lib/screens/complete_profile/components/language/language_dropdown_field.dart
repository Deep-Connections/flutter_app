import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/complete_profile/components/language/language_notifier.dart';
import 'package:deep_connections/utils/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LanguageDropdown extends StatefulWidget {
  final LanguageNotifier languageNotifier;

  const LanguageDropdown({super.key, required this.languageNotifier});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final localeNames = getLocaleNames(context);
    return ListenableBuilder(
      builder: (context, child) {
        return TypeAheadField<MapEntry<String, String>>(
          controller: controller,
          suggestionsCallback: (pattern) {
            return localeNames
                .where((language) => language.value
                    .toLowerCase()
                    .contains(pattern.toLowerCase()))
                .toList();
          },
          hideOnSelect: false,
          builder: (context, controller, focusNode) {
            return TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: loc.completeProfile_languagePlaceholder,
                    errorText: widget.languageNotifier.errorText));
          },
          itemBuilder: (context, language) {
            return Padding(
                padding: const EdgeInsets.all(standardPadding / 2),
                child: Text(getLanguageText(context, language.key),
                    style: theme.textTheme.bodyLarge));
          },
          onSelected: (language) {
            controller.clear();
            widget.languageNotifier.onSelected(language);
          },
        );
      },
      listenable: widget.languageNotifier,
    );
  }
}
