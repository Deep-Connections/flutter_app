import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../../utils/loc_key.dart';

@Injectable(as: AuthService)
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DcUser? _fromFirebaseUser(User? user) {
    return user?.let(DcUser.fromFirebaseUser);
  }

  Future<Response<T>> handleAuthErrors<T>(Future<T?> Function() callback,
      {LocKey Function(FirebaseAuthException)? getUiErrorMessage}) async {
    try {
      return createResponse(await callback());
    } on FirebaseAuthException catch (e) {
      print(e.message);
      final uiMessage = getUiErrorMessage?.call(e);
      uiMessage ?? MessageHandler.showError(e.message ?? 'An error occurred');
      return ExceptionRes(e, uiMessage: getUiErrorMessage?.call(e));
    }
  }

  @override
  Future<Response<DcUser>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return createResponse(_fromFirebaseUser(userCredential.user));
    } on FirebaseAuthException catch (e) {
      print("${e.message}  ${e.code}");
      final uiMessage = getLoginUiMessage(e);
      return ExceptionRes(e, uiMessage: uiMessage);
    }
  }

  LocKey getLoginUiMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return LocKey((loc) => loc.auth_emailInvalidError);
      case 'user-disabled':
        return LocKey((loc) => loc.login_userDisabledError);
      case 'invalid-credential':
        return LocKey((loc) => loc.login_wrongCredentialsError);
      default:
        return DefaultError;
    }
  }

  @override
  Future<Response<DcUser>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return createResponse(_fromFirebaseUser(userCredential.user));
    } on FirebaseAuthException catch (e) {
      print(e.message);
      final uiMessage = getRegisterUiMessage(e);
      return ExceptionRes(e, uiMessage: uiMessage);
    }
  }

  LocKey getRegisterUiMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return LocKey((loc) => loc.register_emailExistsError);
      case 'invalid-email':
        return LocKey((loc) => loc.auth_emailInvalidError);
      case 'weak-password':
        return LocKey((loc) => loc.register_passwordWeakError);
      default:
        return DefaultError;
    }
  }

  @override
  Future sendPasswordResetEmail({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      final uiMessage = getResetPasswordUiMessage(e);
      return ExceptionRes(e, uiMessage: uiMessage);
    }
  }

  LocKey getResetPasswordUiMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return LocKey((loc) => loc.auth_emailInvalidError);
      case 'user-not-found':
        return LocKey((loc) => loc.forgotPassword_emailNotFoundError);
      default:
        return DefaultError;
    }
  }

  @override
  Future signOut() async {
    return handleAuthErrors(() => _auth.signOut());
  }
}
