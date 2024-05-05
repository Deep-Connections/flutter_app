import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const minAnswerValue = 0.0;
const maxAnswerValue = 1.0;
const sliderMiddleValue = 0.5;

bool isValidConfidence(double? confidence) =>
    confidence != null &&
    confidence >= minAnswerValue &&
    confidence <= maxAnswerValue;

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

  bool isAnswerValid(Answer answer) => isValidConfidence(answer.confidence);

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

  List<String> _validatedChoiceIds(List<String>? choiceIds) => (choiceIds ?? [])
      .where((choiceId) => choices.any((choice) => choice.id == choiceId))
      .toList();

  @override
  bool isAnswerValid(Answer answer) {
    final choiceIds = answer.choices;
    if (choiceIds == null ||
        !choiceIds.every(
            (choiceId) => choices.any((choice) => choiceId == choice.id))) {
      return false;
    }
    final confidence = answer.confidence;
    if (choices.any((c) => c.confidence != null) &&
        !isValidConfidence(confidence)) {
      return false;
    }
    if (choiceIds.length < minChoices) return false;
    if (choiceIds.length > maxChoices) return false;
    return true;
  }

  Answer? createAnswer(List<Choice> selectedChoices) {
    final answerValue = choices.any((c) => c.confidence != null)
        ? selectedChoices.fold<double>(
            0.0, (sum, choice) => sum + (choice.confidence ?? 0))
        : null;
    final answer = Answer(
        choices: selectedChoices.map((choice) => choice.id).toList(),
        confidence: answerValue);
    return isAnswerValid(answer) ? answer : null;
  }

  @override
  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    final choiceIds1 = _validatedChoiceIds(myAnswer.choices);
    final choiceIds2 = otherAnswer.choices ?? [];
    final commonIds =
        choiceIds1.where((choiceId) => choiceIds2.contains(choiceId));
    if (commonIds.isEmpty) return null;
    return Answer(choices: commonIds.toList());
  }

  @override
  String? localizeAnswer(Answer answer, AppLocalizations loc) {
    return (answer.choices ?? []).mapNotNull((choiceId) {
      return choices
          .firstWhereOrNull((choice) => choice.id == choiceId)
          ?.text
          .localize(loc);
    }).join(", ");
  }
}

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

  @override
  Answer? findCommonAnswer(Answer myAnswer, Answer otherAnswer) {
    if (!isAnswerValid(myAnswer) || !isAnswerValid(otherAnswer)) return null;
    final mySliderValue = myAnswer.confidence;
    final otherSliderValue = otherAnswer.confidence;
    if (mySliderValue != null && mySliderValue == otherSliderValue) {
      return Answer(confidence: mySliderValue);
    }
    return null;
  }

  @override
  String? localizeAnswer(Answer answer, AppLocalizations loc) {
    if (!isAnswerValid(answer)) return null;
    final double? sliderValue = answer.confidence;
    if (sliderValue == null) return null;
    if (sliderValue == minAnswerValue) return minText.localize(loc);
    if (sliderValue == maxAnswerValue) return maxText.localize(loc);
    if (middleText != null && sliderValue == sliderMiddleValue) {
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
}
