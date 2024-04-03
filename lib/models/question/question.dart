import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/choice_question.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

abstract class Question {
  final String id;
  final LocKey questionText;
  final QuestionResponse? Function(Profile) fromProfile;
  final Profile Function(Profile, QuestionResponse) updateProfile;

  Question({
    required this.id,
    required this.questionText,
    required this.fromProfile,
    required this.updateProfile,
  });
}

final relationShipTypeQuestion = ChoiceQuestion(
  id: '1',
  questionText: LocKey((loc) => loc.question_relationshipType_question),
  answers: [
    Answer('1', LocKey((loc) => loc.question_relationshipType_answer1)),
    Answer('2', LocKey((loc) => loc.question_relationshipType_answer2)),
    Answer('3', LocKey((loc) => loc.question_relationshipType_answer3)),
    Answer('4', LocKey((loc) => loc.question_relationshipType_answer4)),
  ],
  fromProfile: (p) => p.question1,
  updateProfile: (p, r) => p.copyWith(question1: r),
);
