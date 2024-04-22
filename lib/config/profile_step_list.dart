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
    createWidget: (profileService, navigateToNext) => NameProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
    ),
    isEditable: false,
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'birthdate',
    fromProfile: (profile) => profile.birthdate,
    title: LocKey((loc) => loc.completeProfile_birthdayTitle),
    createWidget: (profileService, navigateToNext) => BirthdayProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
    ),
    isEditable: false,
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'gender',
    fromProfile: (profile) => profile.gender,
    title: LocKey((loc) => loc.completeProfile_genderTitle),
    createWidget: (profileService, navigateToNext) => GenderProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
    ),
  ),
  ProfileNavigationStepWithWidget(
    navigationPath: 'gender_preferences',
    fromProfile: (profile) => profile.genderPreferences,
    title: LocKey((loc) => loc.completeProfile_genderPreferencesTitle),
    createWidget: (profileService, navigateToNext) =>
        GenderPreferencesProfileScreen(
      profileService: profileService,
      navigateToNext: navigateToNext,
    ),
  ),
  ...initialQuestionList
];

final List<ProfileNavigationStep> additionalProfileStepList = [
  ...additionalQuestionList
];

final List<ProfileNavigationStep> allProfileStepList =
    initialProfileStepList + additionalProfileStepList;
