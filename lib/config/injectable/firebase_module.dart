import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:deep_connections/services/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModuleProd {
  @prod
  @singleton
  FirebaseAuth get auth => FirebaseAuth.instance;

  @prod
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @prod
  @singleton
  FirebaseStorage get storage => FirebaseStorage.instance;

  @prod
  @singleton
  FirebaseFunctions get functions =>
      FirebaseFunctions.instanceFor(region: Regions.europeWest6);
}

const _firebaseEmulatorHost = 'localhost';

@module
abstract class FirebaseModuleDev {
  @dev
  @singleton
  FirebaseAuth get auth =>
      FirebaseAuth.instance..useAuthEmulator(_firebaseEmulatorHost, 9099);

  @dev
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance
    ..useFirestoreEmulator(_firebaseEmulatorHost, 8080);

  @dev
  @singleton
  FirebaseStorage get storage =>
      FirebaseStorage.instance..useStorageEmulator(_firebaseEmulatorHost, 9199);

  @dev
  @singleton
  FirebaseFunctions get functions =>
      FirebaseFunctions.instanceFor(region: Regions.europeWest6)
        ..useFunctionsEmulator(_firebaseEmulatorHost, 5001);
}
