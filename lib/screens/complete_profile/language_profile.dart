import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/complete_profile/components/future_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/components/language/language_dropdown_field.dart';
import 'package:deep_connections/screens/complete_profile/components/language/language_notifier.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/language_helper.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  LanguageNotifier languageNotifier = LanguageNotifier();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return StreamBuilder(
        stream: widget.profileService.profileStream,
        builder: (context, snap) {
          final codes = snap.data?.languageWithCountryCodes;
          final localeNames = getLocaleNames(context);
          if (codes != null) {
            languageNotifier.selectedLanguages = Map.fromEntries(codes
                .mapNotNull((languageCode) => localeNames
                    .firstWhereOrNull((element) => element.key == languageCode))
                .toList());
          }
          return BaseProfileScreen(
              title: loc.completeProfile_languageTitle,
              bottom: ElevatedButton(
                onPressed: () {
                  if (!languageNotifier.isValid(loc)) return;
                  widget.navigateToNext();
                  widget.profileService.updateProfile((profile) {
                    final languages =
                        languageNotifier.selectedLanguages.keys.toList();
                    return profile.copyWith(
                        languageCodes: languages
                            .map((lang) => lang.split("_").first)
                            .toSet()
                            .toList(),
                        languageWithCountryCodes: languages);
                  });
                },
                child: Text(widget.submitText.localize(loc)),
              ),
              child: DcListView(
                children: [
                  ListenableBuilder(
                      listenable: languageNotifier,
                      builder: (context, child) {
                        return Wrap(
                          spacing: standardPadding / 2,
                          children: [
                            ...languageNotifier.selectedLanguages.entries.map(
                              (lang) => Chip(
                                label: Text(
                                    getLanguageText(context, lang.key,
                                        languageName: lang.value),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    overflow: TextOverflow.ellipsis),
                                onDeleted: () => languageNotifier.remove(lang),
                              ),
                            )
                          ],
                        );
                      }),
                  LanguageDropdown(
                    languageNotifier: languageNotifier,
                  ),
                ],
              ));
        });
  }
}
