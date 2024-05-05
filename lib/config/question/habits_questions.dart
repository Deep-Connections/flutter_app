import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> habitsQuestionList = [
  MultipleChoiceQuestion(
    id: 'smoking',
    questionText: LocKey((loc) => loc.questionHabit_smoking_question),
    choices: [
      Choice('daily', LocKey((loc) => loc.questionHabit_smoking_answer_daily)),
      Choice(
          'weekly', LocKey((loc) => loc.questionHabit_smoking_answer_weekly)),
      Choice(
          'rarely', LocKey((loc) => loc.questionHabit_smoking_answer_rarely)),
      Choice('never', LocKey((loc) => loc.questionHabit_smoking_answer_never)),
    ],
    navigationPath: 'smoking',
    section: ProfileSection.habits,
  ),
  MultipleChoiceQuestion(
      id: 'drinking',
      questionText: LocKey((loc) => loc.questionHabit_drinking_question),
      choices: [
        Choice(
            'often', LocKey((loc) => loc.questionHabit_drinking_answer_often)),
        Choice('weekly',
            LocKey((loc) => loc.questionHabit_drinking_answer_weekly)),
        Choice('occasion',
            LocKey((loc) => loc.questionHabit_drinking_answer_occasion)),
        Choice(
            'never', LocKey((loc) => loc.questionHabit_drinking_answer_never)),
      ],
      navigationPath: 'drinking',
      section: ProfileSection.habits),
  MultipleChoiceQuestion(
    id: 'meals',
    questionText: LocKey((loc) => loc.questionHabit_meals_question),
    choices: [
      Choice(
          'takeOut', LocKey((loc) => loc.questionHabit_meals_answer_takeOut)),
      Choice(
          'selfMade', LocKey((loc) => loc.questionHabit_meals_answer_selfMade)),
      Choice(
          'healthy', LocKey((loc) => loc.questionHabit_meals_answer_healthy)),
    ],
    navigationPath: 'meals',
    section: ProfileSection.habits,
  ),
  MultipleChoiceQuestion(
    id: 'diet',
    questionText: LocKey((loc) => loc.questionHabit_diet_question),
    choices: [
      Choice(
          'omnivore', LocKey((loc) => loc.questionHabit_diet_answer_omnivore)),
      Choice('flexitarian',
          LocKey((loc) => loc.questionHabit_diet_answer_flexitarian)),
      Choice('vegetarian',
          LocKey((loc) => loc.questionHabit_diet_answer_vegetarian)),
      Choice('vegan', LocKey((loc) => loc.questionHabit_diet_answer_vegan)),
      Choice('other', LocKey((loc) => loc.questionHabit_diet_answer_other))
    ],
    navigationPath: 'diet',
    section: ProfileSection.habits,
  ),
  SliderQuestion(
    id: 'health',
    questionText: LocKey((loc) => loc.questionHabit_health_question),
    minText: LocKey((loc) => loc.questionHabit_health_answerMin),
    maxText: LocKey((loc) => loc.questionHabit_health_answerMax),
    navigationPath: 'health',
    section: ProfileSection.habits,
  ),
  MultipleChoiceQuestion(
    id: 'physical_activity',
    questionText: LocKey((loc) => loc.questionHabit_physicalActivity_question),
    choices: [
      Choice('weekly',
          LocKey((loc) => loc.questionHabit_physicalActivity_answer_weekly)),
      Choice('twoTimes',
          LocKey((loc) => loc.questionHabit_physicalActivity_answer_twoTimes)),
      Choice('fourTimes',
          LocKey((loc) => loc.questionHabit_physicalActivity_answer_fourTimes)),
    ],
    navigationPath: 'physical_activity',
    section: ProfileSection.habits,
  ),
  MultipleChoiceQuestion(
    id: 'mindfulness',
    questionText: LocKey((loc) => loc.questionHabit_mindfulness_question),
    choices: [
      Choice(
          'daily', LocKey((loc) => loc.questionHabit_mindfulness_answer_daily)),
      Choice('weekly',
          LocKey((loc) => loc.questionHabit_mindfulness_answer_weekly)),
      Choice('rarely',
          LocKey((loc) => loc.questionHabit_mindfulness_answer_rarely)),
      Choice(
          'never', LocKey((loc) => loc.questionHabit_mindfulness_answer_never)),
    ],
    navigationPath: 'mindfulness',
    section: ProfileSection.habits,
  ),
  SliderQuestion(
    id: 'minimalism',
    questionText: LocKey((loc) => loc.questionHabit_minimalism_question),
    minText: LocKey((loc) => loc.questionHabit_minimalism_answerMin),
    maxText: LocKey((loc) => loc.questionHabit_minimalism_answerMax),
    navigationPath: 'minimalism',
    section: ProfileSection.habits,
  )
];
