import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> politicsQuestionList = [
  SliderQuestion(
    id: 'politics',
    questionText: LocKey((loc) => loc.question_politicalSpectrum_question),
    minValue: 1,
    maxValue: 5,
    minText: LocKey((loc) => loc.question_politicalSpectrum_answerMin),
    maxText: LocKey((loc) => loc.question_politicalSpectrum_answerMax),
    navigationPath: 'politics',
    section: ProfileSection.politics,
  ),
];
