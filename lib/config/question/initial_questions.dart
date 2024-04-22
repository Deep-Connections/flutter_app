import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> initialQuestionList = [
  MultipleChoiceQuestion(
    id: 'relationship',
    questionText: LocKey((loc) => loc.question_relationshipType_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_relationshipType_answer1)),
      Answer('2', LocKey((loc) => loc.question_relationshipType_answer2)),
      Answer('3', LocKey((loc) => loc.question_relationshipType_answer3)),
      Answer('4', LocKey((loc) => loc.question_relationshipType_answer4)),
    ],
    navigationPath: 'relationship',
    section: ProfileSection.profile,
  ),
  MultipleChoiceQuestion(
    id: "language",
    questionText: LocKey((loc) => loc.question_languages_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_languages_answer1)),
      Answer('2', LocKey((loc) => loc.question_languages_answer2)),
      Answer('3', LocKey((loc) => loc.question_languages_answer3)),
      Answer('4', LocKey((loc) => loc.question_languages_answer4)),
      Answer('5', LocKey((loc) => loc.question_languages_answer5)),
    ],
    maxChoices: 5,
    section: ProfileSection.profile,
    navigationPath: 'language',
  ),
  MultipleChoiceQuestion(
    id: 'current_life',
    questionText: LocKey((loc) => loc.question_currentLife_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_currentLife_answer1)),
      Answer('2', LocKey((loc) => loc.question_currentLife_answer2)),
      Answer('3', LocKey((loc) => loc.question_currentLife_answer3)),
    ],
    navigationPath: 'current_life',
    section: ProfileSection.profile,
  ),
];
