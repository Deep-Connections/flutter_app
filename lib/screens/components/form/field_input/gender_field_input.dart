import 'package:deep_connections/utils/extensions/general_extensions.dart';
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
    if (value?.customName != null) super.value = value!.customName;
    notifyListeners();
  }

  @override
  clickOnGender(Gender gender) => selectedGender = gender;

  SingleGenderInput()
      : super(placeholder: LocKey((loc) => loc.input_genderPlaceholder));

  final _genderRegex =
  RegExp(r"^[\p{L}\s\-]+$", unicode: true, caseSensitive: false);

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (selectedGender != null) {
      return null;
    } else {
      if (value == null || !_genderRegex.hasMatch(value)) {
        return loc.input_genderError;
      } else {
        selectedGender = Gender.fromCustomName(value);
      }
    }
    return null;
  }

  @override
  String get value => throw UnimplementedError();

  @override
  set value(String? value) {
    throw UnimplementedError();
  }

  @override
  bool isSelected(Gender gender) => selectedGender == gender;

  @override
  String? moreText(loc) {
    return !Gender.base.contains(selectedGender)
        ? selectedGender?.localize(loc)
        : null;
  }

  @override
  void Function(BuildContext context)? get onTap =>
          (_) => selectedGender = null;
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
    final genderNotPresent = !_selectedGenders.remove(gender);
    if (genderNotPresent) {
      // If everyone is clicked, we remove other genders
      if (gender == Gender.everyone) {
        _selectedGenders.clear();
      }
      // When we add a gender, we remove everyone (in case it's present)
      _selectedGenders.remove(Gender.everyone);

      // If gender is not present, we add it.
      _selectedGenders.add(gender);
    }
    notifyListeners();
  }

  List<String> get value {
    final genders = _selectedGenders.any((g) => g == Gender.everyone)
        ? Gender.values
        : _selectedGenders;
    return genders.map((e) => e.enumValue).toList();
  }

  set value(List<String>? genderEnums) {
    if (genderEnums != null && genderEnums.isNotEmpty) {
      _selectedGenders.clear();
      final uniqueGenders = genderEnums.toSet().toList();
      final List<Gender> genders =
      uniqueGenders.mapNotNull((g) => Gender.fromEnum(g));
      if (genders.any((g) => g == Gender.everyone) ||
          genders.length == Gender.values.length) {
        _selectedGenders.add(Gender.everyone);
      } else {
        _selectedGenders.addAll(genders);
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
    _selectedGenders.where((g) => Gender.additionalOther.contains(g));
    return genders.isEmpty
        ? null
        : genders.map((e) => e.localize(loc)).join(", ");
  }
}
