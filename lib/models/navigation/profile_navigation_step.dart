import 'package:deep_connections/models/navigation/navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';

class ProfileNavigationStep<T> extends NavigationStep {
  final T? Function(Profile) fromProfile;
  final Profile Function(Profile, T) updateProfile;

  ProfileNavigationStep(
      {required super.navigationPath,
      required this.fromProfile,
      required this.updateProfile});
}
