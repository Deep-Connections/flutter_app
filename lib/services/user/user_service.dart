import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../firebase/firebase_exceptions.dart';

@singleton
class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw UserNotFoundException();
    }
    return userId;
  }

  DcUser? _fromFirebaseUser(User? user) {
    return user?.let(DcUser.fromFirebaseUser);
  }

  Stream<DcUser?> get userStream {
    return _auth.authStateChanges().map(_fromFirebaseUser);
  }
}
