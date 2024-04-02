import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'field_input/field_input.dart';

class DcTextFormField extends StatefulWidget {
  final FieldInput fieldInput;
  final TextInputAction textInputAction;
  final String? error;

  const DcTextFormField({
    Key? key,
    required this.fieldInput,
    this.textInputAction = TextInputAction.next,
    this.error,
  }) : super(key: key);

  @override
  State<DcTextFormField> createState() => _DcTextFormFieldState();
}

class _DcTextFormFieldState extends State<DcTextFormField> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: widget.fieldInput,
      builder: (context, child) {
        final fieldInput = widget.fieldInput;
        return TextFormField(
          onChanged: fieldInput.onChanged,
          controller: fieldInput.controller,
          keyboardType: fieldInput.keyboardType,
          maxLength: fieldInput.maxLength,
          inputFormatters: fieldInput.inputFormatter,
          decoration: InputDecoration(
            hintText: fieldInput.placeholder?.localize(loc),
            errorText: widget.error,
          ),
          validator: (value) =>
              fieldInput.validator(fieldInput.preProcess(value), loc),
          textInputAction: widget.textInputAction,
          enabled: fieldInput.enabled,
          obscureText: fieldInput.obscureText,
          readOnly: fieldInput.readOnly,
          onTap: fieldInput.onTap != null
              ? () => fieldInput.onTap!(context)
              : null,
        );
      },
    );
  }
}
