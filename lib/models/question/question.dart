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

  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    return null;
  }

  String? localizeAnswer(Answer answer, AppLocalizations loc) {
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

  List<String> _validatedChoiceValues(List<String>? choiceValues) =>
      (choiceValues ?? [])
          .where((choiceValue) =>
              choices.any((choice) => choice.value == choiceValue))
          .toList();

  bool isAnswerValid(Answer answer) {
    final choiceValues = _validatedChoiceValues(answer.response);
    if (choiceValues.length < minChoices) return false;
    if (choiceValues.length > maxChoices) return false;
    return true;
  }

  @override
  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    final choiceValues1 = _validatedChoiceValues(myAnswer.response);
    final choiceValues2 = otherAnswer.response ?? [];
    final commonValues = choiceValues1
        .where((choiceValue) => choiceValues2.contains(choiceValue));
    if (commonValues.isEmpty) return null;
    return Answer(response: commonValues.toList());
  }

  @override
  String? localizeAnswer(Answer answer, AppLocalizations loc) {
    return (answer.response ?? []).mapNotNull((choiceValue) {
      return choices
          .firstWhereOrNull((choice) => choice.value == choiceValue)
          ?.text
          .localize(loc);
    }).join(", ");
  }
}

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  final int defaultValue;
  final LocKey minText;
  final LocKey maxText;
  final LocKey? middleText;

  get divisions => maxValue - minValue;

  const SliderQuestion({
    required super.id,
    required super.questionText,
    required this.minValue,
    required this.maxValue,
    int? defaultValue,
    required this.minText,
    required this.maxText,
    this.middleText,
    required super.navigationPath,
    required super.section,
  }) : defaultValue = defaultValue ?? (minValue + maxValue) ~/ 2;

  int? _validatedSliderValue(List<String>? value) {
    if (value == null || value.isEmpty) return null;
    final intValue = int.tryParse(value.first);
    final clampedValue = intValue?.clamp(minValue, maxValue);
    if (intValue != null && intValue == clampedValue) return intValue;
    return null;
  }

  @override
  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    final mySliderValue = _validatedSliderValue(myAnswer.response);
    final otherSliderValue = _validatedSliderValue(otherAnswer.response);
    if (mySliderValue != null && mySliderValue == otherSliderValue) {
      return Answer(response: [mySliderValue.toString()]);
    }
    return null;
  }

  @override
  String? localizeAnswer(Answer answer, AppLocalizations loc) {
    final int? sliderValue = _validatedSliderValue(answer.response);
    if (sliderValue == null) return null;
    if (sliderValue == minValue) return minText.localize(loc);
    if (sliderValue == maxValue) return maxText.localize(loc);
    final middleValue = (minValue + maxValue) / 2;
    if (middleText != null && sliderValue.toDouble() == middleValue) {
      return middleText!.localize(loc);
    }
    if (sliderValue < middleValue) {
      return minText.localize(loc);
    }
    if (sliderValue > middleValue) {
      return maxText.localize(loc);
    }
    return null;
  }
}
