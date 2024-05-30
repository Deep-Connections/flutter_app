import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/firebase_constants.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:deep_connections/services/utils/handle_firebase_errors.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: ProfileService)
class FirebaseProfileService implements ProfileService {
  final UserService _userService;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseProfileService(this._userService, this._firestore, this._storage);

  CollectionReference<Profile> get _profileReference =>
      _firestore.collection(Collection.profiles).withConverter<Profile>(
          fromFirestore: (doc, _) => Profile.fromJson(doc.withId()),
          toFirestore: (profile, _) => profile.toJson());

  late final _profileSubject = BehaviorSubject<Profile?>()
    ..addStream(_userService.userIdStream.switchMap((userId) {
      if (userId == null) return Stream.value(null);

      logger.d("Profile Stream reinitialized");
      return _profileReference
          .doc(userId)
          .snapshots()
          .map((snapshot) => snapshot.data() ?? const Profile());
    }));

  @override
  Stream<Profile?> get profileStream => _profileSubject.stream;

  @override
  Future<Response<void>> updateProfile(Profile Function(Profile p) transform,
      {void Function(Profile)? onUpdatedProfile}) async {
    onUpdatedProfile?.call(transform(profile ?? const Profile()));
    return handleFirebaseErrors(() => _profileReference
        .doc(_userService.userId)
        .set(transform(const Profile()), SetOptions(merge: true)));
  }

  @override
  Profile? get profile => _profileSubject.valueOrNull;

  final _profiles = <String, Profile?>{};

  @override
  FutureOr<Profile?> profileByUserId(String? userId) {
    if (userId == null) return null;
    if (_profiles.containsKey(userId)) return _profiles[userId];
    return _profileReference.doc(userId).get().then((value) {
      final profile = value.data();
      _profiles[userId] = profile;
      return profile;
    });
  }

  Reference get _imageRef => _storage
      .ref()
      .child(StorageCollection.profileImages)
      .child(_userService.userId);

  @override
  Future<Response<Picture>> uploadPicture(
      Uint8List pictureFile, String? mimeType) async {
    final userId = _userService.userId;
    final timestamp = DateTime.now();
    final fileEnding = mimeType?.split("/").last ?? "";
    var pictureName = "${timestamp.millisecondsSinceEpoch}.$fileEnding";
    final size = pictureFile.lengthInBytes;
    if (size > maxImageSize) {
      return ErrorRes(
          errorCode: "file_too_large",
          errorMessage: "The file is too large. Max size is 2MB.",
          uiMessage: LocKey((loc) => loc.profilePhotos_imageSizeError));
    }
    return await handleFirebaseErrors(() async {
      final ref = _imageRef.child(pictureName);
      await ref.putData(
          pictureFile,
          SettableMetadata(
            contentType: mimeType,
          ));
      final url = await ref.getDownloadURL();
      final picture =
          Picture(url: url, timestamp: timestamp, name: pictureName);
      _profileReference.doc(userId).update({
        FieldName.pictures: FieldValue.arrayUnion([picture.toJson()])
      });
      return Picture(url: url, timestamp: timestamp);
    });
  }

  @override
  Future<Response<void>> deletePicture(Picture picture) async {
    final pictureName = picture.name;
    if (pictureName == null) {
      return ErrorRes(
          errorCode: "no_picture_name",
          errorMessage: "The picture you're deleting has no name.");
    }
    return await handleFirebaseErrors(() async {
      final userId = _userService.userId;
      final ref = _imageRef.child(pictureName);
      try {
        await ref.delete();
      } on FirebaseException catch (e) {
        if (![StorageErrors.objectNotFound, StorageErrors.unauthorized]
            .contains(e.code)) {
          rethrow;
        }
      }
      final pictureToRemove =
          profile?.pictures?.firstWhere((p) => p.name == pictureName);
      if (pictureToRemove == null) return;
      _profileReference.doc(userId).update({
        FieldName.pictures: FieldValue.arrayRemove([pictureToRemove.toJson()])
      });
    });
  }
}
