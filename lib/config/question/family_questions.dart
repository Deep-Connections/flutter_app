import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> familyQuestionList = [
  MultipleChoiceQuestion(
    id: 'kids',
    questionText: LocKey((loc) => loc.questionFamily_kids_question),
    choices: [
      Choice('have', LocKey((loc) => loc.questionFamily_kids_answer_have)),
      Choice('want', LocKey((loc) => loc.questionFamily_kids_answer_want)),
      Choice(
          'haveWant', LocKey((loc) => loc.questionFamily_kids_answer_haveWant)),
      Choice('dont', LocKey((loc) => loc.questionFamily_kids_answer_dont)),
      Choice('unsure', LocKey((loc) => loc.questionFamily_kids_answer_unsure)),
    ],
    navigationPath: 'kids',
    section: ProfileSection.family,
  ),
  MultipleChoiceQuestion(
    id: 'when_kids',
    questionText: LocKey((loc) => loc.questionFamily_kidsWhen_question),
    choices: [
      Choice('soon', LocKey((loc) => loc.questionFamily_kidsWhen_answer_soon)),
      Choice('five', LocKey((loc) => loc.questionFamily_kidsWhen_answer_five)),
      Choice('later', LocKey((loc) => loc.questionFamily_kidsWhen_answer_later))
    ],
    minChoices: 0,
    navigationPath: 'when_kids',
    section: ProfileSection.family,
  ),
  MultipleChoiceQuestion(
    id: 'parenting',
    questionText: LocKey((loc) => loc.questionFamily_parenting_question),
    choices: [
      Choice('work', LocKey((loc) => loc.questionFamily_parenting_answer_work)),
      Choice('both', LocKey((loc) => loc.questionFamily_parenting_answer_both)),
      Choice('parenting',
          LocKey((loc) => loc.questionFamily_parenting_answer_parenting))
    ],
    minChoices: 0,
    navigationPath: 'parenting',
    section: ProfileSection.family,
  ),
  MultipleChoiceQuestion(
    id: 'pets',
    questionText: LocKey((loc) => loc.questionFamily_pets_question),
    choices: [
      Choice('never', LocKey((loc) => loc.questionFamily_pets_answer_never)),
      Choice('ratherNot',
          LocKey((loc) => loc.questionFamily_pets_answer_ratherNot)),
      Choice('ratherYes',
          LocKey((loc) => loc.questionFamily_pets_answer_ratherYes)),
      Choice('must', LocKey((loc) => loc.questionFamily_pets_answer_must))
    ],
    navigationPath: 'pets',
    section: ProfileSection.family,
  ),
];
