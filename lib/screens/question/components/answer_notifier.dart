import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:flutter/material.dart';

class AnswerNotifier extends ChangeNotifier {
  Answer? _answer;

  Answer? get answer => _answer;

  set answer(Answer? answer) {
    if (_answer?.confidence != answer?.confidence ||
        _answer?.choices != answer?.choices) {
      if (answer?.importance == null) {
        _answer = answer?.copyWith(importance: _answer?.importance);
      } else {
        _answer = answer;
      }
      notifyListeners();
    }
  }

  set importance(double importance) {
    if (_answer?.importance != importance) {
      _answer = (_answer ?? const Answer()).copyWith(importance: importance);
    } else {
      _answer = _answer?.copyWith(importance: null);
    }
    notifyListeners();
  }
}
