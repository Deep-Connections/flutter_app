import 'package:flutter/material.dart';

abstract class TextFieldInput {
  final TextInputType keyboardType;
  final int? maxLength;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final TextEditingController controller = TextEditingController();

  TextFieldInput({
    required this.keyboardType,
    this.maxLength,
    this.placeholder,
    this.textInputAction,
  });

  String? validator(String? value) => null;

  String get value => controller.text;
}

class EmailInput extends TextFieldInput {
  EmailInput()
      : super(keyboardType: TextInputType.emailAddress, placeholder: "Email");

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
            placeholder: "Password");

  @override
  String? validator(String? value) {
    if (value == null || value.length < 8) {
      return 'Please enter a password with 8+ characters';
    }
    return null;
  }
}
