import 'package:deep_connections/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DcUser? _fromFirebaseUser(User? user) {
    return user?.let(DcUser.fromFirebaseUser);
  }

  Future<DcUser?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _fromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<DcUser?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _fromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sendPasswordResetEmail({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Stream<DcUser?> get userStream {
    return _auth.authStateChanges().map(_fromFirebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
