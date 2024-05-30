import 'dart:async';
import 'dart:typed_data';

import 'package:deep_connections/models/profile/picture/picture.dart';

import '../../models/profile/profile/profile.dart';
import '../utils/response.dart';

abstract class ProfileService {
  Stream<Profile?> get profileStream;

  Profile? get profile;

  Future<Response<void>> updateProfile(
      Profile Function(Profile profile) transform,
      {void Function(Profile)? onUpdatedProfile});

  FutureOr<Profile?> profileByUserId(String? userId);

  Future<Response<Picture>> uploadPicture(Uint8List image, String? mimeType);

  Future<Response<void>> deletePicture(Picture picture);
}
