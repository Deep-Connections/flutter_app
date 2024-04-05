import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

class UserStatus {
  final DcUser? user;
  final ProfileNavigationStep? unCompletedStep;

  UserStatus({this.user, this.unCompletedStep});

  bool get isAuthenticated => user != null;

  bool get isProfileComplete => unCompletedStep == null;
}

UserStatus userStatusFromFirebaseUser(User? user) {
  return UserStatus(user: user?.let((user) => DcUser.fromFirebaseUser(user)));
}
