import 'package:deep_connections/models/question/question.dart';

import 'question/family_questions.dart';
import 'question/free_time_questions.dart';
import 'question/habits_questions.dart';
import 'question/initial_questions.dart';
import 'question/personality_questions.dart';
import 'question/politics_questions.dart';
import 'question/religion_questions.dart';

final List<Question> additionalQuestionList = habitsQuestionList +
    politicsQuestionList +
    personalityQuestionList +
    freeTimeQuestionList +
    familyQuestionList +
    spiritualityQuestionList;

final allQuestionsList = initialQuestionList + additionalQuestionList;
