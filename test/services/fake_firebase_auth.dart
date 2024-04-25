import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';

const correctEmail = 'correct@email.com';
const correctPassword = 'Correct123. ';

final mockUser = MockUser(
  isAnonymous: false,
  uid: '1234',
  email: correctEmail,
  displayName: 'Bob',
);

MockFirebaseAuth getSignedInMockFirebaseAuth() =>
    MockFirebaseAuth(signedIn: true, mockUser: mockUser);

class UnauthFakeFirebaseAuth extends Mock implements FirebaseAuth {
  var isSignedIn = false;
  var isRegistered = false;

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    if (email == correctEmail && password == correctPassword) {
      isSignedIn = true;
      return MockUserCredential();
    } else {
      throw FirebaseAuthException(code: 'invalid-credential');
    }
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    if (email == correctEmail) {
      throw FirebaseAuthException(code: 'email-already-in-use');
    } else {
      isRegistered = true;
      return MockUserCredential();
    }
  }
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User get user => mockUser;
}
