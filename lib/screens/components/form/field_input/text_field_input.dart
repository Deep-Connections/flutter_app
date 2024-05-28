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
    Iterable<String>? autoFillHints,
  }) : super(
          keyboardType: keyboardType,
          placeholder: placeholder,
          obscureText: obscureText,
          inputFormatter: inputFormatters,
          autoFillHints: autoFillHints,
        );

  @override
  String convert(String value) => value;
}

class EmailInput extends TextFieldInput {
  EmailInput()
      : super(
            keyboardType: TextInputType.emailAddress,
            autoFillHints: [AutofillHints.email],
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
  final bool isRegistration;

  PasswordInput({this.isRegistration = false})
      : super(
            keyboardType: TextInputType.visiblePassword,
            placeholder: LocKey((loc) => loc.input_passwordPlaceholder),
            obscureText: true,
            autoFillHints: [
              isRegistration
                  ? AutofillHints.newPassword
                  : AutofillHints.password
            ]);

  final minPasswordLength = 8;
  final uppercaseRegex = RegExp(r'[A-Z]');
  final lowercaseRegex = RegExp(r'[a-z]');
  final numberRegex = RegExp(r'[0-9]');

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (value == null || value.isEmpty) {
      return loc.auth_passwordNoneError;
    }
    if (isRegistration) {
      if (value.length < minPasswordLength) {
        return loc.auth_passwordLengthError;
      }
      if (!value.contains(uppercaseRegex)) {
        return loc.auth_passwordUppercaseError;
      }
      if (!value.contains(lowercaseRegex)) {
        return loc.auth_passwordLowercaseError;
      }
      if (!value.contains(numberRegex)) {
        return loc.auth_passwordNumberError;
      }
    }
    return null;
  }

  @override
  String? preProcess(String? value) => value;
}

class FirstNameInput extends TextFieldInput {
  FirstNameInput()
      : super(
            placeholder: LocKey((loc) => loc.input_firstNamePlaceholder),
            autoFillHints: [AutofillHints.givenName]);

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
