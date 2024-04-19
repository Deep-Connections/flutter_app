import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/choice_question.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/slider_question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> initialQuestionList = [
  MultipleChoiceQuestion(
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
    navigationPath: 'relationship',
    section: ProfileSection.profile,
  ),
  MultipleChoiceQuestion(
    id: "3",
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
    fromProfile: (p) => p.question3,
    updateProfile: (p, r) => p.copyWith(question3: r),
  ),
  MultipleChoiceQuestion(
    id: '4',
    questionText: LocKey((loc) => loc.question_currentLife_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_currentLife_answer1)),
      Answer('2', LocKey((loc) => loc.question_currentLife_answer2)),
      Answer('3', LocKey((loc) => loc.question_currentLife_answer3)),
    ],
    fromProfile: (p) => p.question4,
    updateProfile: (p, r) => p.copyWith(question4: r),
    navigationPath: 'current_life',
    section: ProfileSection.profile,
  ),
];

final List<Question> additionalQuestionList = [
  SliderQuestion(
    id: '2',
    questionText: LocKey((loc) => loc.question_politicalSpectrum_question),
    minValue: 1,
    maxValue: 5,
    minText: LocKey((loc) => loc.question_politicalSpectrum_answerMin),
    maxText: LocKey((loc) => loc.question_politicalSpectrum_answerMax),
    fromProfile: (p) => p.question2,
    updateProfile: (p, r) => p.copyWith(question2: r),
    navigationPath: 'politics',
    section: ProfileSection.politics,
  ),
];
