import 'package:deep_connections/config/question/initial_questions.dart';
import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/screens/complete_profile/birthday_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/gender_preferences/gender_preferences_profile_screen.dart';
import 'package:deep_connections/screens/complete_profile/language_profile.dart';
import 'package:deep_connections/screens/complete_profile/name_profile_screen.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<ProfileNavigationStep> initialProfileStepList = [
  ProfileNavigationStepWithWidget(
    navigationPath: 'name',
    fromProfile: (profile) => profile.firstName,
    title: LocKey((loc) => loc.completeProfile_firstNameTitle),
    createWidget: (profileStream, updateProfile, submitText) =>
        NameProfileScreen(
      profileStream: profileStream,
      updateProfile: updateProfile,
      submitText: submitText,
    ),
    isEditable: false,
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'birthdate',
    fromProfile: (profile) => profile.dateOfBirth,
    title: LocKey((loc) => loc.completeProfile_birthdayTitle),
    createWidget: (profileStream, updateProfile, submitText) =>
        BirthdayProfileScreen(
      profileStream: profileStream,
      updateProfile: updateProfile,
      submitText: submitText,
    ),
    isEditable: false,
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'gender',
    fromProfile: (profile) => profile.gender,
    title: LocKey((loc) => loc.completeProfile_genderTitle),
    createWidget: (profileStream, updateProfile, submitText) =>
        GenderProfileScreen(
      profileStream: profileStream,
      updateProfile: updateProfile,
      submitText: submitText,
    ),
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'gender_preferences',
    fromProfile: (profile) => profile.genderPreferences,
    title: LocKey((loc) => loc.completeProfile_genderPreferencesTitle),
    createWidget: (profileStream, updateProfile, submitText) =>
        GenderPreferencesProfileScreen(
      profileStream: profileStream,
      updateProfile: updateProfile,
      submitText: submitText,
    ),
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'languages',
    fromProfile: (profile) {
      final languageCodes = profile.languageCodes;
      final languageWithCountryCodes = profile.languageWithCountryCodes;
      if (languageCodes != null && languageWithCountryCodes != null) {
        return [languageCodes, languageWithCountryCodes];
      }
    },
    title: LocKey((loc) => loc.completeProfile_languageTitle),
    createWidget: (profileStream, updateProfile, submitText) =>
        LanguageProfileScreen(
      profileStream: profileStream,
      updateProfile: updateProfile,
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
