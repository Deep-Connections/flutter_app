import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class TextFieldInput {
  final TextInputType keyboardType;
  final int? maxLength;
  final String? Function(AppLocalizations)? getPlaceholder;
  final TextInputAction? textInputAction;
  final bool obscureText;

  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> enabled = ValueNotifier(true);

  TextFieldInput({
    required this.keyboardType,
    this.maxLength,
    this.getPlaceholder,
    this.textInputAction,
    this.obscureText = false,
  });

  String? validator(String? value, AppLocalizations loc) => null;

  String get value => controller.text;
}

class EmailInput extends TextFieldInput {
  EmailInput()
      : super(
            keyboardType: TextInputType.emailAddress,
            getPlaceholder: (loc) => loc.input_emailPlaceholder);

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (value == null || !value.contains('@') || !value.contains('.')) {
      return loc.input_emailValidError;
    }
    return null;
  }
}

class PasswordInput extends TextFieldInput {
  PasswordInput()
      : super(
            keyboardType: TextInputType.visiblePassword,
            getPlaceholder: (loc) => loc.input_passwordPlaceholder,
            obscureText: true);

  @override
  String? validator(String? value, AppLocalizations loc) {
    if (value == null || value.length < 8) {
      return loc.input_passwordLengthError;
    }
    return null;
  }
}
