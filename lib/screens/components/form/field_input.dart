import 'package:deep_connections/utils/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class TextFieldInput {
  final TextInputType keyboardType;
  final int? maxLength;
  final LocKey? placeholder;
  final TextInputAction? textInputAction;
  final bool obscureText;

  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> enabled = ValueNotifier(true);

  TextFieldInput({
    required this.keyboardType,
    this.maxLength,
    this.placeholder,
    this.textInputAction,
    this.obscureText = false,
  });

  String? validator(String? value, AppLocalizations loc) => null;

  /// Pre-processes the input value before it is used or validated.
  String? preProcess(String? value) => value?.trim();

  void setError(String error) {}

  String get value => preProcess(controller.text) ?? "";
}

class EmailInput extends TextFieldInput {
  EmailInput()
      : super(
            keyboardType: TextInputType.emailAddress,
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
