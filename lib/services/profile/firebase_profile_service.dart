import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/utils/user_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/profile.dart';
import '../utils/handle_firebase_errors.dart';
import '../utils/response.dart';

const String _PROFILES_COLLECTION = 'profiles';

@injectable
class FirebaseProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> getUserProfileReference() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw UserNotFoundException();
    return _firestore.collection(_PROFILES_COLLECTION).doc(userId);
  }

  Future<Response<void>> updateProfile(Profile profile) async {
    return handleFirebaseErrors(() => getUserProfileReference()
        .set(profile.toJson(), SetOptions(merge: true)));
  }
}
