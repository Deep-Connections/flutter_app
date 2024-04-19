import 'package:deep_connections/config/question_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Check that question ids are unique', () async {
    final areQuestionIdsUnique =
        allQuestions.map((e) => e.id).toSet().length == allQuestions.length;
    if (!areQuestionIdsUnique) {
      throw Exception('Question ids are not unique');
    }
  });
}
