import 'package:deep_connections/models/user.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/user/user_status.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/loc_key.dart';

const CORRECT_EMAIL = 'correct@email.com';
const CORRECT_PASSWORD = 'correct123. ';

class MockAuthService implements AuthService {
  var isSignedIn = false;

  @override
  Future<Response<UserStatus>> loginWithEmail(
      {required String email, required String password}) {
    if (email == CORRECT_EMAIL && password == CORRECT_PASSWORD) {
      isSignedIn = true;
      return Future.value(SuccessRes(UserStatus(
          user: DcUser(
        email: email,
        uid: '1',
      ))));
    } else {
      return Future.value(ExceptionRes(Exception('Invalid credentials'),
          uiMessage: LocKey((loc) => loc.login_wrongCredentialsError)));
    }
  }

  @override
  Future<Response<UserStatus>> registerWithEmail(
      {required String email, required String password}) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }

  @override
  Future sendPasswordResetEmail({required String email}) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
