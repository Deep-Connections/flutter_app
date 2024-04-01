import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/gender.dart';
import 'text_field_input.dart';

class SingleGenderInput extends TextFieldInput {
  Gender? _selectedGender;

  Gender? get selectedGender => _selectedGender;

  set selectedGender(Gender? value) {
    _selectedGender = value;
    notifyListeners();
  }

  SingleGenderInput()
      : super(placeholder: LocKey((loc) => loc.input_genderPlaceholder));

  @override
  void Function(String p1) get onChanged => (_) {
        if (selectedGender != null) {
          selectedGender = null;
          notifyListeners();
        }
      };

  @override
  String get value => selectedGender?.enumValue ?? super.value;

  @override
  set value(String? value) {
    Gender? gender =
        Gender.all.firstWhereOrNull((gender) => gender.enumValue == value);
    if (gender != null) {
      selectedGender = gender;
    } else {
      selectedGender = null;
      super.value = value;
    }
  }
}

class MultipleGenderInput extends ChangeNotifier {
  var _enabled = true;

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  final List<Gender> _selectedGenders = [];

  List<Gender> get selectedGenders => _selectedGenders;

  void toggleGender(Gender gender) {
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
        final gender =
            Gender.all.firstWhereOrNull((gender) => gender.enumValue == value);
        if (gender != null) {
          _selectedGenders.add(gender);
        }
      }
      notifyListeners();
    }
  }
}