import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

class UserStatus {
  final DcUser? user;
  final bool profileComplete;

  UserStatus({this.user, this.profileComplete = false});

  bool get isAuthenticated => user != null;

  bool get isProfileComplete => profileComplete;
}

UserStatus userStatusFromFirebaseUser(User? user) {
  return UserStatus(user: user?.let((user) => DcUser.fromFirebaseUser(user)));
}
