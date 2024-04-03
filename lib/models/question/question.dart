import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

class Question {
  final String id;
  final LocKey questionText;
  final int minChoices;
  final int maxChoices;
  final List<Answer> answers;
  final QuestionResponse? Function(Profile) fromProfile;
  final Profile Function(Profile, QuestionResponse) updateProfile;

  Question(
      {required this.id,
      required this.questionText,
      this.minChoices = 1,
      this.maxChoices = 1,
      required this.answers,
      required this.fromProfile,
      required this.updateProfile});
}

class Answer {
  final int value;
  final LocKey answerText;

  Answer(this.value, this.answerText);
}

final relationShipTypeQuestion = Question(
  id: '1',
  questionText: LocKey((loc) => loc.question_relationshipType_question),
  answers: [
    Answer(1, LocKey((loc) => loc.question_relationshipType_answer1)),
    Answer(2, LocKey((loc) => loc.question_relationshipType_answer2)),
    Answer(3, LocKey((loc) => loc.question_relationshipType_answer3)),
    Answer(4, LocKey((loc) => loc.question_relationshipType_answer4)),
  ],
  fromProfile: (p) => p.question1,
  updateProfile: (p, r) => p.copyWith(question1: r),
);
