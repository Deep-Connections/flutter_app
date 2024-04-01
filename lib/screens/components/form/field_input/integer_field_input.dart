import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'field_input.dart';

abstract class IntegerFieldInput extends FieldInput<int> {
  IntegerFieldInput({
    LocKey? placeholder,
    int? maxLength,
  }) : super(
            keyboardType: TextInputType.number,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            placeholder: placeholder,
            maxLength: maxLength);

  @override
  String? validator(String? value, AppLocalizations loc) => null;

  @override
  int convert(String value) => int.parse(value);
}

class HeightInput extends IntegerFieldInput {
  HeightInput()
      : super(
            placeholder: LocKey((loc) => loc.input_sizePlaceholder),
            maxLength: 3);

  @override
  String? validator(String? value, AppLocalizations loc) {
    final size = int.tryParse(value ?? '');
    if (value == null ||
        value.isEmpty ||
        size == null ||
        size < 50 ||
        size > 250) {
      return loc.input_sizeError;
    }
    return null;
  }
}
