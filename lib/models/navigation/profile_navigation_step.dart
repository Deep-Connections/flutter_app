import 'package:deep_connections/models/navigation/navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/profile/birthday_profile_screen.dart';
import 'package:deep_connections/screens/profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/screens/profile/name_profile_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/cupertino.dart';

class ProfileNavigationStep<T> extends NavigationStep {
  final T? Function(Profile) fromProfile;

  ProfileNavigationStep(
      {required super.navigationPath, required this.fromProfile});
}

abstract class ProfileNavigationStepWithWidget<T>
    extends ProfileNavigationStep<T> {
  Widget createWidget(
      ProfileService profileService, Future<void> Function() navigateToNext);

  ProfileNavigationStepWithWidget(
      {required super.navigationPath, required super.fromProfile});
}

class NameProfileNavigationStep
    extends ProfileNavigationStepWithWidget<String> {
  NameProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });

  @override
  Widget createWidget(profileService, navigateToNext) {
    return NameProfileScreen(
        profileService: profileService, navigateToNext: navigateToNext);
  }
}

class BirthdateProfileNavigationStep
    extends ProfileNavigationStepWithWidget<DateTime> {
  BirthdateProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });

  @override
  Widget createWidget(profileService, navigateToNext) {
    return BirthdayProfileScreen(
        profileService: profileService, navigateToNext: navigateToNext);
  }
}

class GenderProfileNavigationStep
    extends ProfileNavigationStepWithWidget<String> {
  GenderProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });

  @override
  Widget createWidget(profileService, navigateToNext) {
    return GenderProfileScreen(
        profileService: profileService, navigateToNext: navigateToNext);
  }
}

class GenderPreferencesProfileNavigationStep
    extends ProfileNavigationStepWithWidget<List<String>> {
  GenderPreferencesProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });

  @override
  Widget createWidget(profileService, navigateToNext) {
    return BirthdayProfileScreen(
        profileService: profileService, navigateToNext: navigateToNext);
  }
}
