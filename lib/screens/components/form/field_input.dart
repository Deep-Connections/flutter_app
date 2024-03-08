import 'package:flutter/material.dart';

import '../../../global.dart';

abstract class TextFieldInput {
  final TextInputType keyboardType;
  final int? maxLength;
  final String? placeholder;
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

  String? validator(String? value) => null;

  String get value => controller.text;
}

class EmailInput extends TextFieldInput {
  EmailInput()
      : super(
            keyboardType: TextInputType.emailAddress,
            placeholder: Global.loc.input_emailPlaceholder);

  @override
  String? validator(String? value) {
    if (value == null || !value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

class PasswordInput extends TextFieldInput {
  PasswordInput()
      : super(
      keyboardType: TextInputType.visiblePassword,
            placeholder: Global.loc.input_passwordPlaceholder,
            obscureText: true);

  @override
  String? validator(String? value) {
    if (value == null || value.length < 8) {
      return 'Please enter a password with 8+ characters';
    }
    return null;
  }
}
