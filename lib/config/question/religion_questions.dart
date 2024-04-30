import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> spiritualityQuestionList = [
  SliderQuestion(
    id: 'religion_importance',
    questionText: LocKey((loc) => loc.questionSpirituality_importance_question),
    minValue: 1,
    maxValue: 4,
    minText: LocKey((loc) => loc.questionSpirituality_importance_answerMin),
    maxText: LocKey((loc) => loc.questionSpirituality_importance_answerMax),
    navigationPath: 'religion_importance',
    section: ProfileSection.spirituality,
  ),
  MultipleChoiceQuestion(
    id: 'same_religion',
    questionText:
        LocKey((loc) => loc.questionSpirituality_sameReligion_question),
    choices: [
      Choice('yes',
          LocKey((loc) => loc.questionSpirituality_sameReligion_answer_yes)),
      Choice(
          'generally',
          LocKey(
              (loc) => loc.questionSpirituality_sameReligion_answer_generally)),
      Choice('no',
          LocKey((loc) => loc.questionSpirituality_sameReligion_answer_no)),
    ],
    navigationPath: 'same_religion',
    section: ProfileSection.spirituality,
  )
];
