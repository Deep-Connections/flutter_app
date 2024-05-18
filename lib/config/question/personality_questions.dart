import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> personalityQuestionList = [
  /*MultipleChoiceQuestion(
    id: 'improving',
    questionText: LocKey((loc) => loc.questionPersonality_improving_question),
    choices: [
      Choice('always',
          LocKey((loc) => loc.questionPersonality_improving_answer_always)),
      Choice('regularly',
          LocKey((loc) => loc.questionPersonality_improving_answer_regularly)),
      Choice(
          'occasionally',
          LocKey(
              (loc) => loc.questionPersonality_improving_answer_occasionally)),
      Choice('rarely',
          LocKey((loc) => loc.questionPersonality_improving_answer_rarely)),
    ],
    navigationPath: 'improving',
    section: ProfileSection.personality,
  ),
  MultipleChoiceQuestion(
    id: 'improvement_focus',
    questionText:
        LocKey((loc) => loc.questionPersonality_improvementFocus_question),
    choices: [
      Choice(
          'career',
          LocKey(
              (loc) => loc.questionPersonality_improvementFocus_answer_career)),
      Choice(
          'emotional',
          LocKey((loc) =>
              loc.questionPersonality_improvementFocus_answer_emotional)),
      Choice(
          'health',
          LocKey(
              (loc) => loc.questionPersonality_improvementFocus_answer_health)),
      Choice(
          'social',
          LocKey(
              (loc) => loc.questionPersonality_improvementFocus_answer_social)),
      Choice(
          'hobbies',
          LocKey((loc) =>
              loc.questionPersonality_improvementFocus_answer_hobbies)),
      Choice(
          'spiritual',
          LocKey((loc) =>
              loc.questionPersonality_improvementFocus_answer_spiritual))
    ],
    maxChoices: 3,
    navigationPath: 'improvement_focus',
    section: ProfileSection.personality,
  ),*/
  /* MultipleChoiceQuestion(
    id: 'importance_comfort_partner',
    questionText:
        LocKey((loc) => loc.questionPersonality_importanceComfortPartner_question),
    choices: [
      Choice(
          'total',
          LocKey(
              (loc) => loc.questionPersonality_importanceComfortPartner_answer_total)),
      Choice(
          'important',
          LocKey((loc) =>
              loc.questionPersonality_importanceComfortPartner_answer_important)),
      Choice('no',
          LocKey((loc) => loc.questionPersonality_importanceComfortPartner_answer_no)),
    ],
    navigationPath: 'importance_comfort_partner',
    section: ProfileSection.personality,
  ), */
  MultipleChoiceQuestion(
    id: 'importance_comfort_friend',
    questionText: LocKey(
        (loc) => loc.questionPersonality_importanceComfortFriend_question),
    choices: [
      Choice(
          'total',
          LocKey((loc) =>
              loc.questionPersonality_importanceComfortFriend_answer_total)),
      Choice(
          'important',
          LocKey((loc) => loc
              .questionPersonality_importanceComfortFriend_answer_important)),
      Choice('no',
          LocKey((loc) =>
              loc.questionPersonality_importanceComfortFriend_answer_no)),
    ],
    navigationPath: 'importance_comfort_friend',
    section: ProfileSection.personality,
  ),
  MultipleChoiceQuestion(
    id: 'emotions',
    questionText: LocKey((loc) => loc.questionPersonality_emotions_question),
    choices: [
      Choice('very',
          LocKey((loc) => loc.questionPersonality_emotions_answer_very)),
      Choice('onlyTrust',
          LocKey((loc) => loc.questionPersonality_emotions_answer_onlyTrust)),
      Choice('dont',
          LocKey((loc) => loc.questionPersonality_emotions_answer_dont)),
    ],
    navigationPath: 'emotions',
    section: ProfileSection.personality,
  ),
  SliderQuestion(
    id: 'self_reflective',
    questionText:
        LocKey((loc) => loc.questionPersonality_selfReflective_question),
    minText: LocKey((loc) => loc.questionPersonality_selfReflective_answerMin),
    maxText: LocKey((loc) => loc.questionPersonality_selfReflective_answerMax),
    navigationPath: 'self_reflective',
    section: ProfileSection.personality,
  ),
  MultipleChoiceQuestion(
    id: 'conflicts_self',
    questionText:
        LocKey((loc) => loc.questionPersonality_conflictsSelf_question),
    choices: [
      Choice(
          'confrontation',
          LocKey((loc) =>
              loc.questionPersonality_conflictsSelf_answer_confrontation)),
      Choice(
          'avoidance',
          LocKey(
              (loc) => loc.questionPersonality_conflictsSelf_answer_avoidance)),
      Choice(
          'compromise',
          LocKey((loc) =>
              loc.questionPersonality_conflictsSelf_answer_compromise)),
      Choice('giveIn',
          LocKey((loc) => loc.questionPersonality_conflictsSelf_answer_giveIn)),
    ],
    maxChoices: 2,
    navigationPath: 'conflicts_self',
    section: ProfileSection.personality,
  ),
  MultipleChoiceQuestion(
    id: 'conflicts_partner',
    questionText:
        LocKey((loc) => loc.questionPersonality_conflictsPartner_question),
    choices: [
      Choice(
          'confrontation',
          LocKey((loc) =>
              loc.questionPersonality_conflictsPartner_answer_confrontation)),
      Choice(
          'avoidance',
          LocKey((loc) =>
              loc.questionPersonality_conflictsPartner_answer_avoidance)),
      Choice(
          'compromise',
          LocKey((loc) =>
              loc.questionPersonality_conflictsPartner_answer_compromise)),
      Choice(
          'giveIn',
          LocKey(
              (loc) => loc.questionPersonality_conflictsPartner_answer_giveIn)),
    ],
    maxChoices: 4,
    navigationPath: 'conflicts_partner',
    section: ProfileSection.personality,
  ),
  MultipleChoiceQuestion(
    id: 'support_need',
    questionText:
        LocKey((loc) => loc.questionPersonality_emotionalSupportNeed_question),
    choices: [
      Choice(
          'listening',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportNeed_answer_listening)),
      Choice(
          'solution',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportNeed_answer_solution)),
      Choice(
          'physical',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportNeed_answer_physical)),
      Choice(
          'distraction',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportNeed_answer_distraction)),
    ],
    maxChoices: 2,
    navigationPath: 'support_need',
    section: ProfileSection.personality,
  ),
  MultipleChoiceQuestion(
    id: 'support_offer',
    questionText:
        LocKey((loc) => loc.questionPersonality_emotionalSupportOffer_question),
    choices: [
      Choice(
          'listening',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportOffer_answer_listening)),
      Choice(
          'solution',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportOffer_answer_solution)),
      Choice(
          'physical',
          LocKey((loc) =>
              loc.questionPersonality_emotionalSupportOffer_answer_physical)),
      Choice(
          'distraction',
          LocKey((loc) => loc
              .questionPersonality_emotionalSupportOffer_answer_distraction)),
    ],
    maxChoices: 2,
    navigationPath: 'support_offer',
    section: ProfileSection.personality,
  )
];
