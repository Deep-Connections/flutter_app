import 'package:firebase_auth/firebase_auth.dart';

class DcUser {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoURL;

  DcUser({required this.id, this.email, this.displayName, this.photoURL});

  factory DcUser.fromFirebaseUser(User user) {
    return DcUser(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }
}

extension FirebaseUserExtensions on User {
  DcUser toDcUser() => DcUser.fromFirebaseUser(this);
}