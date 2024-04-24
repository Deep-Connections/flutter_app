import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/language_helper.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
    var countries = this.countries;
    if (countries == null) {
      final countryMap = LocaleNames.of(context)!
          .sortedByName
          .where((lang) => lang.key.split("_").length == 2)
          .let((countryList) => Map.fromEntries(countryList));
      final firstCountries = firstLanguageCodes.mapNotNull((lang) {
        final removedCountry = countryMap.remove(lang);
        if (removedCountry == null) return null;
        return MapEntry(lang, removedCountry);
      });
      countries = firstCountries + countryMap.entries.toList();
    }
    return this.countries = countries;
  }

  final controller = TextEditingController();
  String? errorText;
  Map<String, String> selectedLanguages = {};

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return StreamBuilder(
        stream: widget.profileService.profileStream,
        builder: (context, snap) {
          final codes = snap.data?.languageWithCountryCodes;
          if (codes != null && selectedLanguages.isEmpty) {
            selectedLanguages = Map.fromEntries(localeNames(context)
                .where((lang) => codes.contains(lang.key))
                .map((lang) => MapEntry(lang.key, lang.value)));
          }
          return BaseProfileScreen(
              title: loc.question_languages_question,
              bottom: ElevatedButton(
                onPressed: () {
                  if (selectedLanguages.isEmpty) {
                    setState(() {
                      errorText = loc.completeProfile_languageError;
                    });
                    return;
                  }
                  widget.navigateToNext();
                  widget.profileService.updateProfile((profile) {
                    final languages = selectedLanguages.keys.toList();
                    return profile.copyWith(
                        languageCodes: languages
                            .map((lang) => lang.split("_").first)
                            .toList(),
                        languageWithCountryCodes: languages);
                  });
                },
                child: Text(widget.submitText.localize(loc)),
              ),
              child: DcListView(
                children: [
                  Wrap(
                    spacing: standardPadding / 2,
                    children: [
                      ...selectedLanguages.entries.map(
                        (lang) => Chip(
                          label: Text(
                              getLanguageText(context, lang.key,
                                  languageName: lang.value),
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis),
                          onDeleted: () {
                            setState(() {
                              selectedLanguages.remove(lang.key);
                            });
                          },
                        ),
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
                          child: Text(getLanguageText(context, language.key),
                              style: theme.textTheme.bodyLarge));
                    },
                    onSelected: (language) {
                      setState(() {
                        controller.clear();
                        final removedValue =
                            selectedLanguages.remove(language.key);
                        if (removedValue == null) {
                          selectedLanguages[language.key] = language.value;
                        }
                      });
                    },
                  )
                ],
              ));
        });
  }
}
