import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:flutter_test/flutter_test.dart';

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

  test(
      'Assert that for slider questions the middle text is set when divisions are odd',
      () async {
    final sliderQuestions = allQuestionsList.whereType<SliderQuestion>();
    for (final question in sliderQuestions) {
      assert((question.divisions % 2 == 1) == (question.middleText != null),
          'middleText must be set when divisions are odd for question: ${question.id}');
    }
  });
}
