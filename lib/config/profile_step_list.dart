import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';

final List<ProfileNavigationStep> initialProfileStepList = [
  NameProfileNavigationStep(
    navigationPath: 'name',
    fromProfile: (profile) => profile.firstName,
  ),
  BirthdateProfileNavigationStep(
    navigationPath: 'birthdate',
    fromProfile: (profile) => profile.birthdate,
  ),
  GenderProfileNavigationStep(
    navigationPath: 'gender',
    fromProfile: (profile) => profile.gender,
  ),
  GenderPreferencesProfileNavigationStep(
    navigationPath: 'gender_preferences',
    fromProfile: (profile) => profile.genderPreferences,
  ),
  ...initialQuestionList
];
