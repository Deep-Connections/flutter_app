import 'package:deep_connections/utils/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class FieldInput<T> {
  final TextInputType keyboardType;
  final int? maxLength;
  final LocKey? placeholder;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscureText;

  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> enabled = ValueNotifier(true);

  FieldInput({
    required this.keyboardType,
    this.maxLength,
    this.placeholder,
    this.inputFormatter,
    this.obscureText = false,
  });

  String? validator(String? value, AppLocalizations loc) => null;

  /// Pre-processes the input value before it is used or validated.
  String? preProcess(String? value) => value?.trim();

  void setError(String error) {}

  T convert(String value) => throw UnimplementedError();

  T get value => convert(preProcess(controller.text)!);
}

class TextFieldInput extends FieldInput<String> {
  TextFieldInput({
    required TextInputType keyboardType,
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
  String? validator(String? value, AppLocalizations loc) => null;

  @override
  String convert(String value) => value;
}

class IntegerFieldInput extends FieldInput<int> {
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

class HeightInput extends IntegerFieldInput {
  HeightInput()
      : super(
            placeholder: LocKey((loc) => loc.profile_sizePlaceholder),
            maxLength: 3);

  @override
  String? validator(String? value, AppLocalizations loc) {
    final size = int.tryParse(value ?? '');
    if (value == null ||
        value.isEmpty ||
        size == null ||
        size < 50 ||
        size > 250) {
      return loc.profile_sizeError;
    }
    return null;
  }
}
