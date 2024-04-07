import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/question.dart';

class MultipleChoiceQuestion extends Question {
  final int minChoices;
  final int maxChoices;
  final List<Answer> answers;

  MultipleChoiceQuestion({
    required super.id,
    required super.questionText,
    this.minChoices = 1,
    this.maxChoices = 1,
    required this.answers,
    required super.navigationPath,
    required super.fromProfile,
    required super.updateProfile,
    required super.section,
  });
}
