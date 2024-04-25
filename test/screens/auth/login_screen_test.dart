import 'package:deep_connections/screens/auth/login_screen.dart';
import 'package:deep_connections/services/auth/firebase_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/fake_firebase_auth.dart';
import '../../test_extensions.dart';

void main() {
  testWidgets('Test login screen with wrong and correct credentials ',
      (WidgetTester tester) async {
    final firebaseAuth = UnauthFakeFirebaseAuth();
    final auth = FirebaseAuthService(firebaseAuth);
    var loginSuccess = false;

    final loc = await tester.pumpLocalizedWidget(LoginScreen(
        auth: auth, onLoginSuccess: () async => loginSuccess = true));
    expect(find.text(loc.login_title), findsOneWidget);
    expect(find.text(loc.auth_emailInvalidError), findsNothing);
    expect(find.text(loc.login_wrongCredentialsError), findsNothing);

    // click login button without entering anything
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();
    expect(find.text(loc.auth_emailInvalidError), findsOneWidget);
    expect(find.text(loc.auth_passwordNoneError), findsOneWidget);

    expect(find.text(loc.input_emailPlaceholder), findsOneWidget);
    expect(find.text(loc.input_passwordPlaceholder), findsOneWidget);

    // enter wrong email and password
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_emailPlaceholder),
        'wrong@email.com');
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_passwordPlaceholder),
        'wrong123.');
    await tester.pump();
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();

    expect(find.text(loc.login_wrongCredentialsError), findsOneWidget);
    expect(firebaseAuth.isSignedIn, false);

    // enter correct email and password
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_emailPlaceholder),
        "$correctEmail "); // Check that email is trimmed
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_passwordPlaceholder),
        correctPassword);
    await tester.pump();
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();

    expect(firebaseAuth.isSignedIn, true);
    expect(loginSuccess, true);
  });
}
