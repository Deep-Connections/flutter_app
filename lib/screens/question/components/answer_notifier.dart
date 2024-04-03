import 'package:flutter/material.dart';

class AnswerNotifier extends ChangeNotifier {
  List<String> _selectedAnswers = [];

  List<String> get selectedAnswer => _selectedAnswers;

  set selectedAnswer(List<String> answers) {
    _selectedAnswers = answers;
    notifyListeners();
  }
}
