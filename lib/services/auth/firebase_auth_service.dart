import 'package:deep_connections/models/user/user.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../utils/loc_key.dart';

@Injectable(as: AuthService)
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LocKey getAuthExceptionMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use': // used
        return LocKey((loc) => loc.register_emailExistsError);
      case 'invalid-email': // unclear if needed
        return LocKey((loc) => loc.auth_emailInvalidError);
      case 'weak-password': // unclear if needed
        return LocKey((loc) => loc.register_passwordWeakError);
      case 'user-disabled': // used
        return LocKey((loc) => loc.login_userDisabledError);
      case 'invalid-credential': // unclear if needed
        return LocKey((loc) => loc.login_wrongCredentialsError);
      case 'network-request-failed': // used
        return LocKey((loc) => loc.general_noInternetError);
      default:
        return defaultError;
    }
  }

  Future<Response<T>> handleAuthErrors<T>(
    Future<T> Function() callback,
  ) async {
    try {
      final res = await callback();
      return SuccessRes(res);
    } on FirebaseAuthException catch (e) {
      final uiMessage = getAuthExceptionMessage(e);
      logger.d(e.stackTrace);
      return ExceptionRes(e, uiMessage: uiMessage);
    }
  }

  @override
  Future<Response<DcUser>> loginWithEmail({
    required String email,
    required String password,
  }) {
    return handleAuthErrors(() async {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user.toDcUserOrThrow();
    });
  }

  @override
  Future<Response<DcUser>> registerWithEmail({
    required String email,
    required String password,
  }) {
    return handleAuthErrors(() async {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user.toDcUserOrThrow();
    });
  }

  @override
  Future<Response<void>> sendPasswordResetEmail({required String email}) {
    return handleAuthErrors(() => _auth.sendPasswordResetEmail(email: email));
  }

  @override
  Future signOut() async {
    return handleAuthErrors(() => _auth.signOut());
  }

  Future<DcUser> _signInWithGoogleWeb() async {
    final googleProvider = GoogleAuthProvider();
    googleProvider.addScope('email');
    final credentialResponse = await _auth.signInWithPopup(googleProvider);
    return credentialResponse.user.toDcUserOrThrow();
  }

  Future<DcUser> _signInWithGoogleMobile() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final credentialResponse = await _auth.signInWithCredential(credential);
    return credentialResponse.user.toDcUserOrThrow();
  }

  @override
  Future<Response<DcUser>> signInWithGoogle() {
    return handleAuthErrors(() {
      if (kIsWeb) {
        return _signInWithGoogleWeb();
      } else {
        return _signInWithGoogleMobile();
      }
    });
  }
}
