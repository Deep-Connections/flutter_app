import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:deep_connections/utils/loc_key.dart';

import '../../../../models/gender.dart';
import 'text_field_input.dart';

class GenderInput extends TextFieldInput {
  Gender? _selectedGender;

  Gender? get selectedGender => _selectedGender;

  set selectedGender(Gender? value) {
    _selectedGender = value;
    notifyListeners();
  }

  GenderInput()
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
