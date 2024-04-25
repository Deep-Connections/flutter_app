import 'dart:io';

import 'package:deep_connections/services/firebase_constants.dart';
import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../services/fake_firebase_auth.dart';
import '../services/mock_firebase_storage.dart';

void main() {
  final securityRules = File('firestore.rules').readAsStringSync();
  final firebaseAuth = getMockFirebaseAuth();
  final userService = UserService(firebaseAuth);
  final firebaseStorage = MockFirebaseStorage();

  test('Logged in user should be allowed to access the profile', () async {
    final profileService = FirebaseProfileService(
        userService,
        FakeFirebaseFirestore(
            authObject: firebaseAuth.authForFakeFirestore,
            securityRules: securityRules),
        firebaseStorage);

    final resp = await profileService
        .updateProfile((p) => p.copyWith(firstName: "John"));
    expect(resp, isA<SuccessRes>());
  });

  test('Logged out user editing profile throws exception', () async {
    final profileService = FirebaseProfileService(
        userService,
        FakeFirebaseFirestore(
            // we pass no auth object here
            securityRules: securityRules),
        firebaseStorage);

    action() async => await profileService
        .updateProfile((p) => p.copyWith(firstName: "John"));
    expect(action, throwsA(isA<Exception>()));
  });

  test('Logged out user reading profile is not allowed', () async {
    final fakeFirestore = FakeFirebaseFirestore(
        authObject: getMockFirebaseAuth(signedIn: false).authForFakeFirestore,
        securityRules: securityRules);
    action() async => await fakeFirestore
        .collection(Collection.profiles)
        .doc("randomid")
        .get();
    expect(action, throwsA(isA<Exception>()));
  });

  test('Logged in user reading profile is allowed', () async {
    final fakeFirestore = FakeFirebaseFirestore(
        authObject: getMockFirebaseAuth(signedIn: true).authForFakeFirestore,
        securityRules: securityRules);
    await fakeFirestore.collection(Collection.profiles).doc("randomid").get();
  });
}
