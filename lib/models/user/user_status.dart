import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';

class UserStatus {
  final Profile? profile;

  UserStatus(this.profile);

  bool get isAuthenticated => profile != null;

  bool get isProfileComplete => uncompletedStep == null;

  bool get isAdditionalProfileComplete => additionalUncompletedStep == null;

  ProfileNavigationStep? _firstUncompletedStep(
      Profile? profile, List<ProfileNavigationStep> stepList) {
    if (profile == null) return stepList.first;
    return stepList
        .firstWhereOrNull((step) => step.fromProfile(profile) == null);
  }

  ProfileNavigationStep? get uncompletedStep {
    return _firstUncompletedStep(profile, initialProfileStepList);
  }

  ProfileNavigationStep? get additionalUncompletedStep {
    return _firstUncompletedStep(profile, additionalProfileStepList);
  }
}
