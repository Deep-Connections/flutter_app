import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:flutter/material.dart';

class AnswerNotifier extends ChangeNotifier {
  Answer? _answer;

  Answer? get answer => _answer;

  set answer(Answer? answer) {
    if (_answer != answer) {
      _answer = answer;
      notifyListeners();
    }
  }

}
