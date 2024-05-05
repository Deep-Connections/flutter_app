import 'package:collection/collection.dart';
import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trotter/trotter.dart';

import 'test_extensions.dart';

void main() {
  test('Check that question ids are unique', () async {
    final areQuestionIdsUnique =
        allQuestionsList.map((e) => e.id).toSet().length ==
            allQuestionsList.length;
    if (!areQuestionIdsUnique) {
      throw Exception('Question ids are not unique');
    }
  });

  test('Check that question choice ids are unique', () async {
    final multipleChoiceQuestions =
        allQuestionsList.whereType<MultipleChoiceQuestion>();
    for (final question in multipleChoiceQuestions) {
      final areChoicesUnique =
          question.choices.map((e) => e.id).toSet().length ==
              question.choices.length;
      if (!areChoicesUnique) {
        throw Exception(
            'Choice ids are not unique for question: ${question.id}');
      }
    }
  });

  test('Slider questions with an odd number of divisions require a middle text',
      () async {
    final sliderQuestions = allQuestionsList.whereType<SliderQuestion>();
    for (final question in sliderQuestions) {
      assert((question.divisions % 2 == 1) == (question.middleText != null),
          'middleText must only be set when divisions are odd for question: ${question.id}');
    }
  });

  testWidgets('Questions texts and longer answers should be unique',
      (widgetTester) async {
    final textSet = <String>{};
    final loc = await widgetTester.pumpLocalizedWidget(const SizedBox());
    for (final question in allQuestionsList) {
      final questionText = question.questionText.localize(loc);
      if (textSet.contains(questionText)) {
        throw Exception(
            "Question text is duplicated for question=${question.id}, text=$questionText");
      }
      textSet.add(questionText);
    }

    const minWords = 3;

    const exemptQuestions = <String>{
      'conflicts_partner',
      'support_offer',
    };

    checkStringUniqueness(Question question, String text) {
      if (text.split(" ").length < minWords) return;
      if (textSet.contains(text)) {
        throw Exception(
            "Text is duplicated for question=${question.id}, text=$text");
      }
      textSet.add(text);
    }

    for (final question in allQuestionsList) {
      if (exemptQuestions.contains(question.id)) continue;
      switch (question) {
        case MultipleChoiceQuestion():
          {
            for (final choice in question.choices) {
              final choiceText = choice.text.localize(loc);
              checkStringUniqueness(question, choiceText);
            }
          }
        case SliderQuestion():
          {
            final minText = question.minText.localize(loc);
            final maxText = question.maxText.localize(loc);
            final middleText = question.middleText?.localize(loc);
            checkStringUniqueness(question, minText);
            checkStringUniqueness(question, maxText);
            if (middleText != null) {
              checkStringUniqueness(question, middleText);
            }
          }
      }
    }
  });

  test('Choice permutation confidence values, if defined should sum up to 1',
      () async {
    final choiceQuestions =
        allQuestionsList.whereType<MultipleChoiceQuestion>();
    for (final question in choiceQuestions) {
      // Skip questions without confidence
      if (question.choices.every((c) => c.confidence == null)) continue;

      // Check that confidence is between 0 and 1 for all choices
      final firstInvalidConfidenceChoice = question.choices.firstWhereOrNull(
          (c) =>
              c.confidence == null || c.confidence! > 1 || c.confidence! < 0);
      if (firstInvalidConfidenceChoice != null) {
        throw Exception(
            'Confidence for choice is not between 0 and 1 for question=${question.id}, choice=${firstInvalidConfidenceChoice.id}');
      }

      final combination = Combinations(question.maxChoices, question.choices);
      for (final choices in combination()) {
        final sumConfidence = choices.fold<double>(
            0.0, (sum, choice) => sum + (choice.confidence ?? 0));
        if (sumConfidence > 1) {
          throw Exception(
              'Sum of confidence for choices is greater than 1 for question=${question.id}, choices=${choices.map((e) => e.id).toList()}');
        }
      }
    }
  });
}
