import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// `LocKey` is a utility class that provides localization support for the application.
///
/// It contains a single property, `localize`, which is a function that takes an instance of `AppLocalizations`
/// and returns a localized string.
///
/// Example usage:
/// ```dart
/// final locKey = LocKey((loc) => loc.someLocalizedString);
/// final localizedString = locKey.localize(AppLocalizations.of(context));
/// ```
class LocKey {
  /// A function that takes an instance of `AppLocalizations` and returns a localized string.
  ///
  /// This function is used to retrieve the localized string for a specific key from the `AppLocalizations` instance.
  final String Function(AppLocalizations loc) localize;

  const LocKey(this.localize);
}

final DefaultError = LocKey((loc) => loc.general_error);
