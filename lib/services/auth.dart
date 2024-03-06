import 'package:deep_connections/services/error_handling.dart';
import 'package:deep_connections/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DcUser? _fromFirebaseUser(User? user) {
    return user?.let(DcUser.fromFirebaseUser);
  }

  Future<T?> handleAuthErrors<T>(Future<T> Function() callback) async {
    try {
      return await callback();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      MessageHandler.showError(e.message ?? 'An error occurred');
    } catch (e) {
      print(e.toString());
      MessageHandler.showError('An error occurred');
    }
    return null;
  }

  Future<UserCredential?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return handleAuthErrors(() => _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ));
  }

  Future<UserCredential?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    return handleAuthErrors(() => _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ));
  }

  Future sendPasswordResetEmail({required String email}) async {
    handleAuthErrors(() => _auth.sendPasswordResetEmail(email: email));
  }

  Stream<DcUser?> get userStream {
    return _auth.authStateChanges().map(_fromFirebaseUser);
  }

  Future signOut() async {
    return handleAuthErrors(() => _auth.signOut());
  }
}
