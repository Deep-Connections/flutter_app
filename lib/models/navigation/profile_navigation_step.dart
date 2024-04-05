import 'package:deep_connections/models/navigation/navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';

class ProfileNavigationStep<T> extends NavigationStep {
  final T? Function(Profile) fromProfile;

  ProfileNavigationStep(
      {required super.navigationPath, required this.fromProfile});
}

class NameProfileNavigationStep extends ProfileNavigationStep<String> {
  NameProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });
}

class BirthdateProfileNavigationStep extends ProfileNavigationStep<DateTime> {
  BirthdateProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });
}

class GenderProfileNavigationStep extends ProfileNavigationStep<String> {
  GenderProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });
}

class GenderPreferencesProfileNavigationStep
    extends ProfileNavigationStep<List<String>> {
  GenderPreferencesProfileNavigationStep({
    required super.navigationPath,
    required super.fromProfile,
  });
}
