import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

sealed class Question extends ProfileNavigationStep<QuestionResponse> {
  final String id;
  final LocKey questionText;

  Profile updateProfile(Profile profile, QuestionResponse questionResponse) {
    final newQuestions = profile.questions ?? {};
    newQuestions[id] = questionResponse;
    return profile.copyWith(questions: newQuestions);
  }

  @override
  QuestionResponse? fromProfile(Profile profile) {
    return profile.questions?[id];
  }

  Question({
    required this.id,
    required this.questionText,
    required super.navigationPath,
    required super.section,
  });
}

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
    required super.section,
  });
}

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  final int defaultValue;
  final LocKey minText;
  final LocKey maxText;

  get divisions => maxValue - minValue;

  SliderQuestion({
    required super.id,
    required super.questionText,
    required this.minValue,
    required this.maxValue,
    int? defaultValue,
    required this.minText,
    required this.maxText,
    required super.navigationPath,
    required super.section,
  }) : defaultValue = defaultValue ?? (minValue + maxValue) ~/ 2;
}