import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  final LocKey minText;
  final LocKey maxText;

  SliderQuestion({
    required String id,
    required LocKey questionText,
    required this.minValue,
    required this.maxValue,
    required this.minText,
    required this.maxText,
    required QuestionResponse? Function(Profile) fromProfile,
    required Profile Function(Profile, QuestionResponse) updateProfile,
  }) : super(
          id: id,
          questionText: questionText,
          fromProfile: fromProfile,
          updateProfile: updateProfile,
        );
}
