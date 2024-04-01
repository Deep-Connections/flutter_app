import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../models/gender.dart';
import 'text_field_input.dart';

abstract class GenderInput extends ChangeNotifier {
  clickOnGender(Gender gender);

  bool isSelected(Gender gender);

  bool get enabled => true;

  String? moreText(AppLocalizations loc) => null;
}

class SingleGenderInput extends TextFieldInput implements GenderInput {
  Gender? _selectedGender;

  Gender? get selectedGender => _selectedGender;

  set selectedGender(Gender? value) {
    _selectedGender = value;
    notifyListeners();
  }

  @override
  clickOnGender(Gender gender) => selectedGender = gender;

  SingleGenderInput()
      : super(placeholder: LocKey((loc) => loc.input_genderPlaceholder));

  /*@override
  void Function(String p1) get onChanged => (_) {
        if (selectedGender != null) {
          _selectedGender = null;
          notifyListeners();
        }
      };*/

  @override
  String get value => selectedGender?.enumValue ?? super.value;

  @override
  set value(String? value) {
    Gender? gender = Gender.fromEnum(value);
    if (gender != null) {
      selectedGender = gender;
    } else {
      super.value = value;
      selectedGender = null;
    }
  }

  @override
  bool isSelected(Gender gender) => selectedGender == gender;

  @override
  String? moreText(loc) {
    String? text;
    if (Gender.additional.contains(selectedGender)) {
      text = selectedGender?.localize(loc);
    }
    if (text == null && super.value.isNotEmpty) {
      text = super.value;
    }
    return text;
  }
}

class MultipleGenderInput extends ChangeNotifier implements GenderInput {
  var _enabled = true;

  @override
  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  final List<Gender> _selectedGenders = [];

  @override
  void clickOnGender(Gender gender) {
    final wasRemoved = _selectedGenders.remove(gender);
    if (!wasRemoved) {
      _selectedGenders.add(gender);
    }
    notifyListeners();
  }

  List<String> get value => _selectedGenders.map((e) => e.enumValue).toList();

  set value(List<String>? genderEnums) {
    if (genderEnums != null && genderEnums.isNotEmpty) {
      _selectedGenders.clear();
      for (final value in genderEnums) {
        final gender = Gender.fromEnum(value);
        if (gender != null) {
          _selectedGenders.add(gender);
        }
      }
      notifyListeners();
    }
  }

  @override
  bool isSelected(Gender gender) {
    return _selectedGenders.contains(gender);
  }

  @override
  String? moreText(AppLocalizations loc) {
    final genders =
        _selectedGenders.where((g) => Gender.additional.contains(g));
    return genders.isEmpty
        ? null
        : genders.map((e) => e.localize(loc)).join(", ");
  }
}
