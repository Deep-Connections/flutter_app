import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class AnswerNotifier extends ChangeNotifier {
  List<String>? _values;

  List<String>? get values => _values;

  set values(List<String>? values) {
    if (_values != values) {
      _values = values;
      notifyListeners();
    }
  }

  Answer? get response => _values?.let((it) => Answer(response: it));
}
