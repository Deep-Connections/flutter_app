import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

class ChoiceQuestion extends Question {
  final int minChoices;
  final int maxChoices;
  final List<Answer> answers;

  ChoiceQuestion({
    required String id,
    required LocKey questionText,
    this.minChoices = 1,
    this.maxChoices = 1,
    required this.answers,
    required QuestionResponse? Function(Profile) fromProfile,
    required Profile Function(Profile, QuestionResponse) updateProfile,
  }) : super(
          id: id,
          questionText: questionText,
          fromProfile: fromProfile,
          updateProfile: updateProfile,
        );
}
