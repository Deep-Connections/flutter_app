import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
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
    ..addStream(_userService.userStream
        .distinct((user1, user2) => user1?.uid == user2?.uid)
        .switchMap((user) {
      if (user == null) return Stream.value(null);

      print("Profile Stream reinitialized");
      return _profileReference
          .doc(user.uid)
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
  Profile? get profile =>
      _profileSubject.hasValue ? _profileSubject.value : null;
}
