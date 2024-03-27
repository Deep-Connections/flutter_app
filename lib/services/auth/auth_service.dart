import 'package:deep_connections/services/user/user_state.dart';

import '../utils/response.dart';

abstract class AuthService {
  Future<Response<UserState>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Response<UserState>> registerWithEmail({
    required String email,
    required String password,
  });

  Future sendPasswordResetEmail({required String email});

  Future signOut();
}
