import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

sealed class Question extends ProfileNavigationStep<Answer> {
  final String id;
  final LocKey questionText;

  const Question({
    required this.id,
    required this.questionText,
    required super.navigationPath,
    required super.section,
  }) : super(isEditable: true, title: questionText);

  Profile updateProfile(Profile profile, Answer questionResponse) {
    Map<String, Answer> newQuestions = Map.from(profile.questions ?? {});
    newQuestions[id] = questionResponse;
    return profile.copyWith(questions: newQuestions);
  }

  @override
  Answer? fromProfile(Profile profile) {
    return profile.questions?[id];
  }

  String? localizeAnswer(Answer response, AppLocalizations loc) {
    return null;
  }
}

class MultipleChoiceQuestion extends Question {
  final int minChoices;
  final int maxChoices;
  final List<Choice> choices;

  const MultipleChoiceQuestion({
    required super.id,
    required super.questionText,
    this.minChoices = 1,
    this.maxChoices = 1,
    required this.choices,
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

  const SliderQuestion({
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
