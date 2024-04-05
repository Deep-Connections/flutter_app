import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/choice_question.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/slider_question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> profileQuestionList = [
  MultipleChoiceQuestion(
    id: '1',
    questionText: LocKey((loc) => loc.question_relationshipType_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_relationshipType_answer1)),
      Answer('2', LocKey((loc) => loc.question_relationshipType_answer2)),
      Answer('3', LocKey((loc) => loc.question_relationshipType_answer3)),
      Answer('4', LocKey((loc) => loc.question_relationshipType_answer4)),
    ],
    minChoices: 2,
    maxChoices: 2,
    fromProfile: (p) => p.question1,
    updateProfile: (p, r) => p.copyWith(question1: r),
    navigationPath: 'relationship',
  ),
  SliderQuestion(
      id: '2',
      questionText: LocKey((loc) => loc.question_politicalSpectrum_question),
      minValue: 1,
      maxValue: 5,
      minText: LocKey((loc) => loc.question_politicalSpectrum_answerMin),
      maxText: LocKey((loc) => loc.question_politicalSpectrum_answerMax),
      fromProfile: (p) => p.question2,
      updateProfile: (p, r) => p.copyWith(question2: r),
      navigationPath: 'politics'),
];
