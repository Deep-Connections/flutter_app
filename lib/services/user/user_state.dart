import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

class UserState {
  final DcUser? user;
  final bool profileComplete;

  UserState({this.user, this.profileComplete = false});

  bool get isAuthenticated => user != null;

  bool get isProfileComplete => profileComplete;
}

UserState userStateFromFirebaseUser(User? user) {
  return UserState(user: user?.let((user) => DcUser.fromFirebaseUser(user)));
}
