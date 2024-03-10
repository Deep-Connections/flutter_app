import 'package:deep_connections/models/response.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/error_handling.dart';
import 'package:deep_connections/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';

@Singleton(as: AuthService)
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DcUser? _fromFirebaseUser(User? user) {
    return user?.let(DcUser.fromFirebaseUser);
  }

  Future<Response<T>> handleAuthErrors<T>(Future<T?> Function() callback,
      {String Function(FirebaseAuthException)? getUiErrorMessage}) async {
    try {
      return createResponse(await callback());
    } on FirebaseAuthException catch (e) {
      print(e.message);
      MessageHandler.showError(e.message ?? 'An error occurred');
      return ExceptionRes(e, uiMessage: getUiErrorMessage?.call(e));
    }
  }

  @override
  Future<Response<DcUser>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return handleAuthErrors(() async {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _fromFirebaseUser(userCredential.user);
    });
  }

  @override
  Future<Response<DcUser>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    return handleAuthErrors(() async {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _fromFirebaseUser(userCredential.user);
    });
  }

  @override
  Future sendPasswordResetEmail({required String email}) async {
    handleAuthErrors(() => _auth.sendPasswordResetEmail(email: email));
  }

  @override
  Stream<DcUser?> get userStream {
    return _auth.authStateChanges().map(_fromFirebaseUser);
  }

  @override
  Future signOut() async {
    return handleAuthErrors(() => _auth.signOut());
  }
}
