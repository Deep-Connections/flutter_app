import 'package:deep_connections/services/user/user_status.dart';

import '../utils/response.dart';

abstract class AuthService {
  Future<Response<UserStatus>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Response<UserStatus>> registerWithEmail({
    required String email,
    required String password,
  });

  Future sendPasswordResetEmail({required String email});

  Future signOut();
}
