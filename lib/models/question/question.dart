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

  Profile updateProfile(Profile profile, Answer answer) {
    Map<String, Answer> newQuestions = Map.from(profile.questions ?? {});
    newQuestions[id] = answer;
    return profile.copyWith(questions: newQuestions);
  }

  bool isAnswerValid(Answer answer);

  @override
  Answer? fromProfile(Profile profile) {
    final answer = profile.questions?[id];
    if (answer == null || !isAnswerValid(answer)) return null;
    return answer;
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
  final double weight;

  const MultipleChoiceQuestion(
      {required super.id,
      required super.questionText,
      this.minChoices = 1,
      this.maxChoices = 1,
      required this.choices,
      required super.navigationPath,
      required super.section,
      this.weight = 1});

  List<String> _validatedChoiceValues(List<String>? choiceValues) =>
      (choiceValues ?? [])
          .where((choiceValue) =>
              choices.any((choice) => choice.id == choiceValue))
          .toList();

  @override
  bool isAnswerValid(Answer answer) {
    final choiceIds = answer.choices;
    if (choiceIds == null ||
        !choiceIds.every(
            (choiceId) => choices.any((choice) => choiceId == choice.id))) {
      return false;
    }
    if (choiceIds.length < minChoices) return false;
    if (choiceIds.length > maxChoices) return false;
    return true;
  }

  @override
  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    final choiceValues1 = _validatedChoiceValues(myAnswer.choices);
    final choiceValues2 = otherAnswer.choices ?? [];
    final commonValues = choiceValues1
        .where((choiceValue) => choiceValues2.contains(choiceValue));
    if (commonValues.isEmpty) return null;
    return Answer(choices: commonValues.toList());
  }

  @override
  String? localizeAnswer(Answer answer, AppLocalizations loc) {
    return (answer.choices ?? []).mapNotNull((choiceValue) {
      return choices
          .firstWhereOrNull((choice) => choice.id == choiceValue)
          ?.text
          .localize(loc);
    }).join(", ");
  }
}

const sliderMinValue = 0.0;
const sliderMaxValue = 1.0;
const sliderMiddleValue = 0.5;

class SliderQuestion extends Question {
  final int divisions;
  final double defaultValue;
  final LocKey minText;
  final LocKey maxText;
  final LocKey? middleText;

  const SliderQuestion({
    required super.id,
    required super.questionText,
    this.divisions = 6,
    double? defaultValue,
    required this.minText,
    required this.maxText,
    this.middleText,
    required super.navigationPath,
    required super.section,
  }) : defaultValue = defaultValue ??
            (1.0 / (divisions - 1)) * ((divisions + 1) ~/ 2 - 1);

  double? _validatedSliderValue(double? value) {
    if (value == null) return null;
    return value.clamp(sliderMinValue, sliderMaxValue);
  }

  @override
  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    final mySliderValue = _validatedSliderValue(myAnswer.value);
    final otherSliderValue = _validatedSliderValue(otherAnswer.value);
    if (mySliderValue != null && mySliderValue == otherSliderValue) {
      return Answer(value: mySliderValue);
    }
    return null;
  }

  @override
  String? localizeAnswer(Answer answer, AppLocalizations loc) {
    final double? sliderValue = _validatedSliderValue(answer.value);
    if (sliderValue == null) return null;
    if (sliderValue == sliderMinValue) return minText.localize(loc);
    if (sliderValue == sliderMaxValue) return maxText.localize(loc);
    if (middleText != null && sliderValue.toDouble() == sliderMiddleValue) {
      return middleText!.localize(loc);
    }
    if (sliderValue < sliderMiddleValue) {
      return loc.questionType_slider_tendency(minText.localize(loc));
    }
    if (sliderValue > sliderMiddleValue) {
      return loc.questionType_slider_tendency(maxText.localize(loc));
    }
    return null;
  }

  @override
  bool isAnswerValid(Answer answer) {
    final sliderValue = answer.value;
    return sliderValue != null &&
        sliderValue >= sliderMinValue &&
        sliderValue <= sliderMaxValue;
  }
}
