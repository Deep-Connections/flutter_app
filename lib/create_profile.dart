import 'dart:math';

import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:flutter/widgets.dart';

final random = Random();

void main(List<String> arguments) {
  WidgetsFlutterBinding.ensureInitialized();
  final profile = generateRandomProfile();
  print(profile);
}

Profile generateRandomProfile() {
  var profile = const Profile();
  for (final question in allQuestionsList) {
    if (question is MultipleChoiceQuestion) {
      final Map<String, Answer> questions = Map.from(profile.questions ?? {});
      final randomIndex = random.nextInt(question.choices.length);
      questions[question.id] = Answer(
        response: [question.choices[randomIndex].value],
      );
      profile = profile.copyWith(questions: questions);
    }
  }
  return profile;
}
