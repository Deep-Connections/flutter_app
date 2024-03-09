import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'field_input.dart';

class DcTextFormField extends StatefulWidget {
  final TextFieldInput fieldInput;
  final TextInputAction textInputAction;

  const DcTextFormField({Key? key,
    required this.fieldInput,
    this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  State<DcTextFormField> createState() => _DcTextFormFieldState();
}

class _DcTextFormFieldState extends State<DcTextFormField> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: widget.fieldInput.enabled,
      builder: (context, enabled, child) {
        return TextFormField(
          controller: widget.fieldInput.controller,
          keyboardType: widget.fieldInput.keyboardType,
          maxLength: widget.fieldInput.maxLength,
          decoration: InputDecoration(
            hintText: widget.fieldInput.getPlaceholder?.call(loc),
          ),
          validator: (value) => widget.fieldInput.validator(value, loc),
          textInputAction: widget.textInputAction,
          enabled: enabled,
          obscureText: widget.fieldInput.obscureText,
        );
      },
    );
  }
}
