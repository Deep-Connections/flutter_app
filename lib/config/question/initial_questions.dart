import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> initialQuestionList = [
  MultipleChoiceQuestion(
    id: 'relationship',
    questionText: LocKey((loc) => loc.questionBasic_relationshipType_question),
    choices: [
      Choice('one_night',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_oneNight)),
      Choice('short',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_short)),
      Choice('long',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_long)),
      Choice('life',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_life)),
    ],
    navigationPath: 'relationship',
    section: ProfileSection.basic,
  ),
  MultipleChoiceQuestion(
    id: 'current_life',
    questionText: LocKey((loc) => loc.questionBasic_currentLife_question),
    choices: [
      Choice('settle',
          LocKey((loc) => loc.questionBasic_currentLife_answer_settle)),
      Choice('career',
          LocKey((loc) => loc.questionBasic_currentLife_answer_career)),
      Choice(
          'find', LocKey((loc) => loc.questionBasic_currentLife_answer_find)),
    ],
    navigationPath: 'current_life',
    section: ProfileSection.basic,
  ),
  SliderQuestion(
    id: 'alone_time',
    questionText: LocKey((loc) => loc.questionBasic_aloneTime_question),
    minText: LocKey((loc) => loc.questionBasic_aloneTime_answerMin),
    maxText: LocKey((loc) => loc.questionBasic_aloneTime_answerMax),
    navigationPath: 'alone_time',
    section: ProfileSection.basic,
  ),
  SliderQuestion(
    id: 'small_talk',
    questionText: LocKey((loc) => loc.questionBasic_smallTalk_question),
    minText: LocKey((loc) => loc.questionBasic_smallTalk_answerMin),
    maxText: LocKey((loc) => loc.questionBasic_smallTalk_answerMax),
    navigationPath: 'small_talk',
    section: ProfileSection.basic,
  ),
  SliderQuestion(
    id: 'looks',
    questionText: LocKey((loc) => loc.questionBasic_looks_question),
    minText: LocKey((loc) => loc.questionBasic_looks_answerMin),
    maxText: LocKey((loc) => loc.questionBasic_looks_answerMax),
    navigationPath: 'looks',
    section: ProfileSection.basic,
  ),
];
