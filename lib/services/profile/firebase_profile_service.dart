import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/profile/profile/profile.dart';
import '../firebase_constants.dart';
import '../utils/handle_firebase_errors.dart';
import '../utils/response.dart';

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
  Future<Response<void>> updateProfile(
      Profile Function(Profile p) callback) async {
    return handleFirebaseErrors(() => _profileReference
        .doc(_userService.userId)
        .set(callback(const Profile()), SetOptions(merge: true)));
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

  @override
  Future<Profile?> getNewMatch(List<String> excludedUserIds) async {
    final excludedIds = [_userService.userId] + excludedUserIds;
    final profiles = await _profileReference
        .where(FieldPath.documentId,
            whereNotIn: excludedIds.length <= 10
                ? excludedIds
                : excludedIds.sublist(0, 10))
        .limit(5)
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
    profiles.shuffle();
    return profiles
        .firstWhereOrNull((profile) => !excludedIds.contains(profile.id));
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
        SerializedField.profilePicture: picture.toJson(),
        SerializedField.pictures: FieldValue.arrayUnion([picture.toJson()])
      });
      return Picture(url: url, timestamp: timestamp);
    });
  }
}
