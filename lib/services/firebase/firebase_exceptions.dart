import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFireStoreException extends FirebaseException
    implements Exception {
  final String code;
  final String message;

  FirebaseFireStoreException({required this.code, required this.message})
      : super(plugin: 'cloud_firestore', message: message, code: code);
}

class UserNotFoundException extends FirebaseAuthException {
  UserNotFoundException(
      {super.code = "user_not_found",
      super.message = "Please login to use this feature."});
}

class DocumentSnapshotNullException extends FirebaseFireStoreException {
  DocumentSnapshotNullException()
      : super(
            code: "document_snapshot_null",
            message: "DocumentSnapshot is null");
}
