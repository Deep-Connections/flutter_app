import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFireStoreException extends FirebaseException {
  FirebaseFireStoreException({required super.code, required super.message})
      : super(plugin: 'cloud_firestore');
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
