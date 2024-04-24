import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

const firstLanguageCodes = ["en", "de", "fr", "it"];

class LanguageProfileScreen extends StatefulWidget {
  final ProfileService profileService;
  final void Function() navigateToNext;
  final LocKey submitText;

  const LanguageProfileScreen({
    super.key,
    required this.profileService,
    required this.navigateToNext,
    required this.submitText,
  });

  @override
  State<LanguageProfileScreen> createState() => _LanguageProfileScreenState();
}

class _LanguageProfileScreenState extends State<LanguageProfileScreen> {
  List<MapEntry<String, String>>? countries;

  List<MapEntry<String, String>> localeNames(BuildContext context) {
    final countries = this.countries ??
        LocaleNames.of(context)!
            .sortedByName
            .where((lang) => lang.key.split("_").length == 1)
            .toList();

    return countries;
  }

  final controller = TextEditingController();
  String? errorText;
  Map<String, String> selectedCountries = {};

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return StreamBuilder(
        stream: widget.profileService.profileStream,
        builder: (context, snap) {
          final codes = snap.data?.languageCodes;
          if (codes != null && selectedCountries.isEmpty) {
            selectedCountries = Map.fromEntries(localeNames(context)
                .where((lang) => codes.contains(lang.key))
                .map((lang) => MapEntry(lang.key, lang.value)));
          }
          return BaseProfileScreen(
              title: loc.question_languages_question,
              bottom: ElevatedButton(
                onPressed: () {
                  if (selectedCountries.isEmpty) {
                    setState(() {
                      errorText = loc.completeProfile_languageError;
                    });
                    return;
                  }
                  widget.navigateToNext();
                  widget.profileService.updateProfile((profile) =>
                      profile.copyWith(
                          languageCodes: selectedCountries.keys.toList()));
                },
                child: Text(widget.submitText.localize(loc)),
              ),
              child: DcListView(
                children: [
                  Text(
                    loc.completeProfile_languageYourLanguages,
                    style: theme.textTheme.labelLarge,
                  ),
                  Row(
                    children: [
                      if (selectedCountries.isEmpty)
                        Text(loc.completeProfile_languageNoLanguagesSelected,
                            style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.5))),
                      Text(
                        selectedCountries.values.join(", "),
                        style: theme.textTheme.bodyLarge,
                      )
                    ],
                  ),
                  TypeAheadField<MapEntry<String, String>>(
                    controller: controller,
                    suggestionsCallback: (pattern) {
                      return localeNames(context)
                          .where((language) => language.value
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    builder: (context, controller, focusNode) {
                      return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: loc.completeProfile_languagePlaceholder,
                              errorText: errorText));
                    },
                    itemBuilder: (context, language) {
                      return Padding(
                        padding: const EdgeInsets.all(standardPadding / 2),
                        child: Text(
                          language.value,
                          style: theme.textTheme.bodyLarge,
                        ),
                      );
                    },
                    onSelected: (language) {
                      setState(() {
                        controller.clear();
                        final removedValue =
                            selectedCountries.remove(language.key);
                        if (removedValue == null) {
                          selectedCountries[language.key] = language.value;
                        }
                      });
                    },
                  )
                ],
              ));
        });
  }
}
