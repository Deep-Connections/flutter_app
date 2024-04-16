import 'dart:async';
import 'dart:typed_data';

import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:rxdart/rxdart.dart';

class MockProfileService implements ProfileService {
  Completer? completer;

  final _profileSubject = BehaviorSubject<Profile?>.seeded(null);

  @override
  get profile => _profileSubject.value;

  set profile(Profile? value) {
    _profileSubject.value = value;
  }

  @override
  Stream<Profile?> get profileStream =>
      _profileSubject.stream as Stream<Profile?>;

  @override
  Future<Response<void>> updateProfile(
      Profile Function(Profile p) callback) async {
    await completer?.future;
    _profileSubject.value = callback(_profileSubject.value ?? const Profile());
    return SuccessRes(null);
  }

  @override
  FutureOr<Profile?> profileByUserId(String? userId) {
    throw UnimplementedError();
  }

  @override
  Future<Profile?> getNewMatch(List<String> excludedUserIds) {
    throw UnimplementedError();
  }

  @override
  Future<Response<Picture>> uploadPicture(Uint8List image) {
    throw UnimplementedError();
  }
}
