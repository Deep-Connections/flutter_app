import 'package:age_calculator/age_calculator.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'field_input.dart';

abstract class DateInput extends FieldInput<DateTime> {
  DateInput({LocKey? placeholder})
      : super(placeholder: placeholder, readOnly: true);

  DateTime? pickedDate;

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (pickedDate == null) {
      return loc.general_error;
    }
    return null;
  }

  @override
  DateTime get value => pickedDate!;

  @override
  set value(DateTime? value) {
    pickedDate = value;
    if (value != null) controller.text = DateFormat.yMd().format(value);
  }

  @override
  void Function(BuildContext context)? get onTap {
    return (context) async {
      final date = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: pickedDate ?? DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (date != null) {
        value = date;
      }
    };
  }
}

class BirthdayInput extends DateInput {
  BirthdayInput()
      : super(placeholder: LocKey((loc) => loc.input_birthdayPlaceholder));

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (pickedDate == null) {
      return loc.input_birthdayError;
    }
    if (AgeCalculator.age(pickedDate!).years < 18) {
      return loc.input_birthdayMinimumError;
    }
    return null;
  }
}
