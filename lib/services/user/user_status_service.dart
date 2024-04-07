import 'package:deep_connections/models/user/user_status.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserStatusService {
  final ProfileService _profileService;

  UserStatusService(this._profileService);

  UserStatus get userStatus => UserStatus(
        _profileService.profile,
      );

  Stream<UserStatus> get userStatusStream {
    return _profileService.profileStream.map((profile) => UserStatus(profile));
  }
}
