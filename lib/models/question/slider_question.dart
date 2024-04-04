import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  final int defaultValue;
  final LocKey minText;
  final LocKey maxText;

  get divisions => maxValue - minValue;

  SliderQuestion({
    required String id,
    required LocKey questionText,
    required this.minValue,
    required this.maxValue,
    int? defaultValue,
    required this.minText,
    required this.maxText,
    required String navigationPath,
    required QuestionResponse? Function(Profile) fromProfile,
    required Profile Function(Profile, QuestionResponse) updateProfile,
  })  : defaultValue = defaultValue ?? (minValue + maxValue) ~/ 2,
        super(
          id: id,
          questionText: questionText,
          fromProfile: fromProfile,
          updateProfile: updateProfile,
          navigationPath: navigationPath,
        );
}
