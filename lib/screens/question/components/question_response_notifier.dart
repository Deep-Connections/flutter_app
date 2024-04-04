import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class QuestionResponseNotifier extends ChangeNotifier {
  List<String>? _values;

  List<String>? get values => _values;

  set values(List<String>? values) {
    if (_values != values) {
      _values = values;
      notifyListeners();
    }
  }

  QuestionResponse? get response =>
      _values?.let((it) => QuestionResponse(response: it));
}
