import 'package:deep_connections/models/question/question.dart';

import 'question/habits_questions.dart';
import 'question/initial_questions.dart';
import 'question/politics_questions.dart';

final List<Question> additionalQuestionList =
    habitsQuestionList + politicsQuestionList;

final allQuestionsList = initialQuestionList + additionalQuestionList;
