import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

abstract class Question extends ProfileNavigationStep<QuestionResponse> {
  final String id;
  final LocKey questionText;
  final Profile Function(Profile, QuestionResponse) updateProfile;

  Question({
    required this.id,
    required this.questionText,
    required super.fromProfile,
    required this.updateProfile,
    required super.navigationPath,
    required super.section,
  });
}
