import 'package:deep_connections/models/user/user.dart';

import '../utils/response.dart';

abstract class AuthService {
  Future<Response<DcUser>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Response<DcUser>> registerWithEmail({
    required String email,
    required String password,
  });

  Future sendPasswordResetEmail({required String email});

  Future signOut();
}
