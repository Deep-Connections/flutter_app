import 'package:deep_connections/models/user/user.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/loc_key.dart';

const correctEmail = 'correct@email.com';
const correctPassword = 'Correct123. ';

class MockAuthService implements AuthService {
  var isSignedIn = false;
  var isRegistered = false;

  @override
  Future<Response<DcUser>> loginWithEmail(
      {required String email, required String password}) {
    if (email == correctEmail && password == correctPassword) {
      isSignedIn = true;
      return Future.value(SuccessRes(DcUser(
        email: email,
        id: '1',
      )));
    } else {
      return Future.value(ExceptionRes(Exception('Invalid credentials'),
          uiMessage: LocKey((loc) => loc.login_wrongCredentialsError)));
    }
  }

  @override
  Future<Response<DcUser>> registerWithEmail(
      {required String email, required String password}) {
    isRegistered = true;
    return Future.value(SuccessRes(DcUser(
      email: email,
      id: '1',
    )));
  }

  @override
  Future<Response<void>> sendPasswordResetEmail({required String email}) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Response<DcUser>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
