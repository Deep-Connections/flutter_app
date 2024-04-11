import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/profile/profile/profile.dart';
import '../firebase_constants.dart';
import '../utils/handle_firebase_errors.dart';
import '../utils/response.dart';

@Singleton(as: ProfileService)
class FirebaseProfileService implements ProfileService {
  final UserService _userService;

  FirebaseProfileService(this._userService);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Profile> get _profileReference =>
      _firestore.collection(Collection.profiles).withConverter<Profile>(
          fromFirestore: (doc, _) => Profile.fromJson(doc.withId()),
          toFirestore: (profile, _) => profile.toJson());

  late final _profileSubject = BehaviorSubject<Profile?>()
    ..addStream(_userService.userIdStream.switchMap((userId) {
      if (userId == null) return Stream.value(null);

      print("Profile Stream reinitialized");
      return _profileReference
          .doc(userId)
          .snapshots()
          .map((snapshot) => snapshot.data() ?? const Profile());
    }));

  @override
  Stream<Profile?> get profileStream => _profileSubject.stream;

  @override
  Future<Response<void>> updateProfile(
      Profile Function(Profile) callback) async {
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
}
