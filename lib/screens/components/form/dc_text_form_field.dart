import 'package:flutter/material.dart';

import 'field_input.dart';

class DcTextFormField extends StatelessWidget {
  final TextFieldInput fieldInput;
  final TextInputAction textInputAction;

  const DcTextFormField(
      {Key? key,
      required this.fieldInput,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldInput.controller,
      keyboardType: fieldInput.keyboardType,
      maxLength: fieldInput.maxLength,
      decoration: InputDecoration(
        hintText: fieldInput.placeholder,
      ),
      validator: fieldInput.validator,
      textInputAction: textInputAction,
    );
  }
}
