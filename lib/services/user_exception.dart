import 'package:firebase_auth/firebase_auth.dart';

class UserNotFoundException extends FirebaseAuthException {
  UserNotFoundException(
      {super.code = "user_not_found",
      super.message = "Please login to use this feature."});
}
