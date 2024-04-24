import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> habitsQuestionList = [
  MultipleChoiceQuestion(
    id: 'smoking',
    questionText: LocKey((loc) => loc.questionHabit_smoking_question),
    answers: [
      Choice('1', LocKey((loc) => loc.questionHabit_smoking_answer1)),
      Choice('2', LocKey((loc) => loc.questionHabit_smoking_answer2)),
      Choice('3', LocKey((loc) => loc.questionHabit_smoking_answer3)),
      Choice('4', LocKey((loc) => loc.questionHabit_smoking_answer4)),
    ],
    navigationPath: 'smoking',
    section: ProfileSection.habits,
  ),
];
