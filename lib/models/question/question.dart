import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

abstract class Question extends ProfileNavigationStep<QuestionResponse> {
  final String id;
  final LocKey questionText;

  Question({
    required this.id,
    required this.questionText,
    required super.fromProfile,
    required super.updateProfile,
    required super.navigationPath,
  });
}
