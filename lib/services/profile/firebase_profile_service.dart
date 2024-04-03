import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

import '../../models/profile/profile.dart';
import '../firebase_constants.dart';
import '../utils/handle_firebase_errors.dart';
import '../utils/response.dart';

@Singleton(as: ProfileService)
class FirebaseProfileService implements ProfileService {
  final UserService _userService;

  FirebaseProfileService(this._userService);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentReference<Profile> get _profileReference => _firestore
      .collection(Collection.profiles)
      .withConverter<Profile>(
          fromFirestore: (doc, _) => Profile.fromJson(doc.withId()),
          toFirestore: (profile, _) => profile.toJson())
      .doc(_userService.userId);

  Profile? _profile;

  @override
  Future<Profile> get profile async {
    _profile ??= (await _profileReference.get()).data() ?? const Profile();
    return _profile!;
  }

  @override
  Future<Response<void>> updateProfile(
      Profile Function(Profile) callback) async {
    var newProfile = callback((await profile));
    _profile = newProfile;
    return handleFirebaseErrors(() => _profileReference.set(
        callback(const Profile()), SetOptions(merge: true)));
  }
}
