import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class FieldInput<T> extends ChangeNotifier {
  final TextInputType? keyboardType;
  final int? maxLength;
  final LocKey? placeholder;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscureText;
  final TextEditingController controller = TextEditingController();

  FieldInput({
    this.keyboardType,
    this.maxLength,
    this.placeholder,
    this.inputFormatter,
    this.obscureText = false,
  });

  void Function(BuildContext context)? onTap;

  void Function(String)? onChanged;

  String? validator(String? value, AppLocalizations loc) => null;

  /// Pre-processes the input value before it is used or validated.
  String? preProcess(String? value) => value?.trim();

  T convert(String value) => throw UnimplementedError();

  T get value => convert(preProcess(controller.text)!);

  set value(T? value) {
    if (value != null) controller.text = value.toString();
  }

  var _enabled = true;

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }
}
