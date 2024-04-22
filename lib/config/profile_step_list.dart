import 'package:deep_connections/config/question/initial_questions.dart';
import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/screens/complete_profile/birthday_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/gender_preferences/gender_preferences_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/name_profile_screen.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<ProfileNavigationStep> initialProfileStepList = [
  ProfileNavigationStepWithWidget(
    navigationPath: 'name',
    fromProfile: (profile) => profile.firstName,
    title: LocKey((loc) => loc.completeProfile_firstNameTitle),
    createWidget: (profileService, navigateToNext, submitText) =>
        NameProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
      submitText: submitText,
    ),
    isEditable: false,
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'birthdate',
    fromProfile: (profile) => profile.birthdate,
    title: LocKey((loc) => loc.completeProfile_birthdayTitle),
    createWidget: (profileService, navigateToNext, submitText) =>
        BirthdayProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
      submitText: submitText,
    ),
    isEditable: false,
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'gender',
    fromProfile: (profile) => profile.gender,
    title: LocKey((loc) => loc.completeProfile_genderTitle),
    createWidget: (profileService, navigateToNext, submitText) =>
        GenderProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
      submitText: submitText,
    ),
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'gender_preferences',
    fromProfile: (profile) => profile.genderPreferences,
    title: LocKey((loc) => loc.completeProfile_genderPreferencesTitle),
    createWidget: (profileService, navigateToNext, submitText) =>
        GenderPreferencesProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
      submitText: submitText,
    ),
  ),
  ...initialQuestionList
];

final List<ProfileNavigationStep> additionalProfileStepList = [
  ...additionalQuestionList
];

final List<ProfileNavigationStep> allProfileStepList =
    initialProfileStepList + additionalProfileStepList;
