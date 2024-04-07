import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';

class UserStatus {
  final Profile? profile;

  UserStatus(this.profile);

  bool get isAuthenticated => profile != null;

  bool get isProfileComplete => uncompletedStep == null;

  ProfileNavigationStep? get uncompletedStep {
    final profile = this.profile;
    if (profile == null) return profileStepList.first;
    return profileStepList
        .firstWhereOrNull((step) => step.fromProfile(profile) == null);
  }
}
