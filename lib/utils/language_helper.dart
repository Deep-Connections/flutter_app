import 'package:flutter/widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

final removeBracketsRegex = RegExp(r'\(.*?\)');

String _countryCodeToFlagEmoji(String languageCode) {
  final languageSplit = languageCode.split('_');
  if (languageSplit.length == 1) {
    return '';
  }
  String countryCode = languageSplit.last;
  // Convert the two-letter country code to uppercase
  countryCode = countryCode.toUpperCase();
  // Create a string buffer to build the emoji
  final StringBuffer emoji = StringBuffer();
  // Convert each character to its corresponding Regional Indicator Symbol
  for (int i = 0; i < countryCode.length; i++) {
    emoji.writeCharCode(countryCode.codeUnitAt(i) + 127397);
  }
  return emoji.toString();
}

_cleanLanguageName(String languageName, bool removeBrackets) {
  if (!removeBrackets) {
    return languageName;
  }
  return languageName.replaceAll(removeBracketsRegex, '');
}

String getLanguageText(BuildContext context, String languageCode,
    {String? languageName, bool removeBrackets = true}) {
  return _cleanLanguageName(
          languageName ??
              LocaleNames.of(context)?.nameOf(languageCode) ??
              languageCode,
          removeBrackets) +
      _countryCodeToFlagEmoji(languageCode);
}

const firstLanguageCodes = [
  "en_US",
  "de_DE",
  "fr_FR",
  "it_IT",
  "de_CH",
  "es_ES",
  "en_GB",
  "pt_PT",
  "nl_NL",
  "da_DK",
  "sv_SE",
  "fi_FI",
  "pl_PL",
  "cs_CZ",
  "hu_HU",
  "ro_RO",
  "sk_SK",
  "el_GR",
  "bg_BG",
  "hr_HR",
  "lt_LT",
  "lv_LV",
  "et_EE",
  "sl_SI"
];
