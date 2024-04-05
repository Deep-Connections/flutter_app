import 'dart:async';

import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/response.dart';

class MockProfileService implements ProfileService {
  Completer? completer;

  Profile testProfile = const Profile();

  @override
  Future<Profile> get profile async => testProfile;

  @override
  Future<Response<void>> updateProfile(
      Profile Function(Profile p) callback) async {
    await completer?.future;
    testProfile = callback(testProfile);
    return SuccessRes(null);
  }
}
