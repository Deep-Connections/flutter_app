import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:deep_connections/services/user/user_status.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class UserStatusService {
  final UserService _userService;
  final ProfileService _profileService;

  UserStatusService(this._userService, this._profileService);

  ProfileNavigationStep? _getUncompletedStep(Profile? profile) {
    if (profile == null) return profileStepList.first;
    return profileStepList
        .firstWhereOrNull((step) => step.fromProfile(profile) == null);
  }

  get userStatus => UserStatus(
        user: _userService.user,
        unCompletedStep: _getUncompletedStep(_profileService.profile),
      );

  Stream<UserStatus?> get userStatusStream {
    return CombineLatestStream.combine2(
        _userService.userStream, _profileService.profileStream,
        (user, profile) {
      final profileUncompletedStep = _getUncompletedStep(profile);
      return UserStatus(
        user: user,
        unCompletedStep: profileUncompletedStep,
      );
    });
  }
}
