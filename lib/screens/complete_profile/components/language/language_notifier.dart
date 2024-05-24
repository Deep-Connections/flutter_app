import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageNotifier extends ChangeNotifier {
  Map<String, String> _selectedLanguages = {};
  String? _errorText;

  set selectedLanguages(Map<String, String> value) {
    _selectedLanguages = value;
    notifyListeners();
  }

  Map<String, String> get selectedLanguages => _selectedLanguages;

  String? get errorText => _errorText;

  remove(MapEntry<String, String> language) {
    final removed = _selectedLanguages.remove(language.key);
    if (removed != null) notifyListeners();
  }

  onSelected(MapEntry<String, String> language) {
    final removedValue = _selectedLanguages.remove(language.key);
    if (removedValue == null) {
      _selectedLanguages[language.key] = language.value;
    }
    notifyListeners();
  }

  isValid(AppLocalizations loc) {
    final isValid = _selectedLanguages.isNotEmpty;
    if (!isValid) {
      _errorText = loc.completeProfile_languageError;
      notifyListeners();
    }
    return isValid;
  }
}
