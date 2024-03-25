import 'package:deep_connections/services/user/user_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../firebase/firebase_exceptions.dart';

@singleton
class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserState get userState => userStateFromFirebaseUser(_auth.currentUser);

  String get userId {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw UserNotFoundException();
    }
    return userId;
  }

  Stream<UserState?> get userStream {
    return _auth.authStateChanges().map(userStateFromFirebaseUser);
  }
}
