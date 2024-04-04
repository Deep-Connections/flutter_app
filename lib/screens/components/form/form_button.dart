import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  final String _text;
  final ButtonInput _buttonInput;
  final Future<void> Function() _action;

  const FormButton(
      {super.key,
      required String text,
      required ButtonInput buttonInput,
      required Future<void> Function() actionIfValid})
      : _text = text,
        _buttonInput = buttonInput,
        _action = actionIfValid;

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  void _setLoading(bool isLoading) {
    setState(() {
      widget._buttonInput.setLoading(isLoading);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !widget._buttonInput.isLoading
          ? () async {
              if (widget._buttonInput.formKey.currentState?.validate() ==
                  true) {
                _setLoading(true);
                await widget._action();
                _setLoading(false);
              }
            }
          : null,
      child: Text(widget._text),
    );
  }
}
