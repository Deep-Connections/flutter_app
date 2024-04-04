import 'package:deep_connections/services/user/user_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../firebase/firebase_exceptions.dart';

@singleton
class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserStatus get userStatus => userStatusFromFirebaseUser(_auth.currentUser);

  String get userId {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw UserNotFoundException();
    }
    return userId;
  }

  Stream<UserStatus?> get userStatusStream {
    return _auth.authStateChanges().map(userStatusFromFirebaseUser);
  }
}
