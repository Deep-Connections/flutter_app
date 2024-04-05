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

  late final _streamController = BehaviorSubject<Profile>()
    ..addStream(_profileReference
        .snapshots()
        .asBroadcastStream()
        .map((event) => event.data() ?? const Profile()));

  DocumentReference<Profile> get _profileReference => _firestore
      .collection(Collection.profiles)
      .withConverter<Profile>(
          fromFirestore: (doc, _) => Profile.fromJson(doc.withId()),
          toFirestore: (profile, _) => profile.toJson())
      .doc(_userService.userId);

  @override
  Stream<Profile> get profile => _streamController.stream;

  @override
  Future<Response<void>> updateProfile(
      Profile Function(Profile) callback) async {
    return handleFirebaseErrors(() => _profileReference.set(
        callback(const Profile()), SetOptions(merge: true)));
  }
}
