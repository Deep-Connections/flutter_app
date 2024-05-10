import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
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
      FirebaseFunctions.instanceFor(region: 'europe-west6');
}

@module
abstract class FirebaseModuleDev {
  @dev
  @singleton
  FirebaseAuth get auth =>
      FirebaseAuth.instance..useAuthEmulator('localhost', 9099);

  @dev
  @singleton
  FirebaseFirestore get firestore =>
      FirebaseFirestore.instance..useFirestoreEmulator('localhost', 8080);

  @dev
  @singleton
  FirebaseStorage get storage =>
      FirebaseStorage.instance..useStorageEmulator('localhost', 9199);

  @dev
  @singleton
  FirebaseFunctions get functions =>
      FirebaseFunctions.instanceFor(region: 'europe-west6')
        ..useFunctionsEmulator('localhost', 5001);
}
