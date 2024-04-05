import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/utils/loc_key.dart';

abstract class Question {
  final String id;
  final String navigationPath;
  final LocKey questionText;
  final QuestionResponse? Function(Profile) fromProfile;
  final Profile Function(Profile, QuestionResponse) updateProfile;

  String navigationFromBasePath(String? basePath) =>
      '$basePath/$navigationPath';

  Question({
    required this.id,
    required this.questionText,
    required this.fromProfile,
    required this.updateProfile,
    required this.navigationPath,
  });
}
