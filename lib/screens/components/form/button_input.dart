import 'package:deep_connections/screens/components/form/field_input.dart';
import 'package:flutter/material.dart';

class ButtonInput {
  bool _isLoading = false;
  final List<TextFieldInput> _fields;
  final formKey = GlobalKey<FormState>();

  ButtonInput({required List<TextFieldInput> fields}) : _fields = fields;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    for (var field in _fields) {
      field.enabled.value = !isLoading;
    }
  }

  bool get isLoading => _isLoading;
}
