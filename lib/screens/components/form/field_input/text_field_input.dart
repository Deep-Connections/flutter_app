import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'field_input.dart';

abstract class TextFieldInput extends FieldInput<String> {
  TextFieldInput({
    TextInputType? keyboardType,
    LocKey? placeholder,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
  }) : super(
          keyboardType: keyboardType,
          placeholder: placeholder,
          obscureText: obscureText,
          inputFormatter: inputFormatters,
        );

  @override
  String convert(String value) => value;
}

class EmailInput extends TextFieldInput {
  EmailInput()
      : super(
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._%+-@]'))
            ],
            placeholder: LocKey((loc) => loc.input_emailPlaceholder));

  @override
  String? validator(String? value, AppLocalizations loc) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,10}$',
    );
    if (value == null || !emailRegex.hasMatch(value)) {
      return loc.auth_emailInvalidError;
    }
    return null;
  }
}

class PasswordInput extends TextFieldInput {
  PasswordInput()
      : super(
            keyboardType: TextInputType.visiblePassword,
            placeholder: LocKey((loc) => loc.input_passwordPlaceholder),
            obscureText: true);

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (value == null || value.length < 8) {
      return loc.auth_passwordLengthError;
    }
    return null;
  }

  @override
  String? preProcess(String? value) => value;
}

class FirstNameInput extends TextFieldInput {
  final _nameRegex =
      RegExp(r"^[\p{L}\s\-']+$", unicode: true, caseSensitive: false);

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (value == null || !_nameRegex.hasMatch(value)) {
      return loc.input_firstNameError;
    }
    return null;
  }
}
