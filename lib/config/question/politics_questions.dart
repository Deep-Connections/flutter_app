import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> politicsQuestionList = [
  SliderQuestion(
    id: 'spectrum',
    questionText: LocKey((loc) => loc.questionPolitics_spectrum_question),
    minValue: 1,
    maxValue: 5,
    minText: LocKey((loc) => loc.questionPolitics_spectrum_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_spectrum_answerMax),
    middleText: LocKey((loc) => loc.questionPolitics_spectrum_answerMiddle),
    navigationPath: 'spectrum',
    section: ProfileSection.politics,
  ),
  SliderQuestion(
    id: 'environment',
    questionText: LocKey((loc) => loc.questionPolitics_environment_question),
    minValue: 1,
    maxValue: 4,
    minText: LocKey((loc) => loc.questionPolitics_environment_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_environment_answerMax),
    navigationPath: 'environment',
    section: ProfileSection.politics,
  ),
  SliderQuestion(
    id: 'racial',
    questionText: LocKey((loc) => loc.questionPolitics_racial_question),
    minValue: 1,
    maxValue: 4,
    minText: LocKey((loc) => loc.questionPolitics_racial_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_racial_answerMax),
    navigationPath: 'racial',
    section: ProfileSection.politics,
  ),
  SliderQuestion(
    id: 'gender_equality',
    questionText: LocKey((loc) => loc.questionPolitics_gender_question),
    minValue: 1,
    maxValue: 4,
    minText: LocKey((loc) => loc.questionPolitics_gender_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_gender_answerMax),
    navigationPath: 'gender_equality',
    section: ProfileSection.politics,
  ),
  SliderQuestion(
    id: 'LGBTQIA+',
    questionText: LocKey((loc) => loc.questionPolitics_LGBTQIA_question),
    minValue: 1,
    maxValue: 4,
    minText: LocKey((loc) => loc.questionPolitics_LGBTQIA_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_LGBTQIA_answerMax),
    navigationPath: 'LGBTQIA+',
    section: ProfileSection.politics,
  ),
];
