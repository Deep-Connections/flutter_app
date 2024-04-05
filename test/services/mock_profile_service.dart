import 'dart:async';

import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:rxdart/rxdart.dart';

class MockProfileService implements ProfileService {
  Completer? completer;

  final BehaviorSubject _profileSubject =
      BehaviorSubject<Profile>.seeded(const Profile());

  get testProfile => _profileSubject.value;

  @override
  Stream<Profile> get profile => _profileSubject.stream as Stream<Profile>;

  @override
  Future<Response<void>> updateProfile(
      Profile Function(Profile p) callback) async {
    await completer?.future;
    _profileSubject.value = callback(_profileSubject.value);
    return SuccessRes(null);
  }
}
