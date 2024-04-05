import 'package:firebase_auth/firebase_auth.dart';

class DcUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  DcUser({required this.uid, this.email, this.displayName, this.photoURL});

  factory DcUser.fromFirebaseUser(User user) {
    return DcUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }
}

extension FirebaseUserExtensions on User {
  DcUser toDcUser() => DcUser.fromFirebaseUser(this);
}