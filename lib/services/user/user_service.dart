import 'package:deep_connections/models/user/user.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../firebase/firebase_exceptions.dart';

@singleton
class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DcUser? get user => _auth.currentUser?.toDcUser();

  String get userId {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw UserNotFoundException();
    }
    return userId;
  }

  Stream<DcUser?> get userStream => _auth
      .authStateChanges()
      .map((user) => user?.let((user) => DcUser.fromFirebaseUser(user)));

  Stream<String?> get userIdStream =>
      userStream.map((user) => user?.id).distinct();
}
