import 'package:firebase_auth/firebase_auth.dart';

class UserNotFoundException extends FirebaseAuthException {
  UserNotFoundException(
      {super.code = "User not logged in",
      super.message = "Please login to use this feature."});
}
