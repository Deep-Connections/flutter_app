import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:flutter/material.dart';

class AnswerNotifier extends ChangeNotifier {
  Answer? _answer;
  bool _enabled = true;

  Answer? get answer => _answer;

  bool get enabled => _enabled;

  set enabled(bool enabled) {
    if (_enabled != enabled) {
      _enabled = enabled;
      notifyListeners();
    }
  }

  set answer(Answer? answer) {
    final oldAnswer = _answer ?? const Answer();

    final newAnswer = (answer ?? const Answer()).copyWith(
      importance: oldAnswer.importance,
    );
    if (oldAnswer.confidence != newAnswer.confidence ||
        oldAnswer.choices != newAnswer.choices) {
      _answer = newAnswer;
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
