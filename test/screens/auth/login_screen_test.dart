import 'package:deep_connections/screens/auth/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_auth_service.dart';
import '../../test_extensions.dart';

void main() {
  testWidgets('Test login screen with wrong and correct credentials ',
      (WidgetTester tester) async {
    final auth = MockAuthService();

    final loc = await tester.pumpLocalizedWidget(LoginScreen(auth: auth));
    expect(find.text(loc.login_title), findsOneWidget);
    expect(find.text(loc.auth_emailInvalidError), findsNothing);
    expect(find.text(loc.login_wrongCredentialsError), findsNothing);

    // click login button without entering anything
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();
    expect(find.text(loc.auth_emailInvalidError), findsOneWidget);
    expect(find.text(loc.auth_passwordLengthError), findsOneWidget);

    expect(find.text(loc.input_emailPlaceholder), findsOneWidget);
    expect(find.text(loc.auth_passwordLengthError), findsOneWidget);

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
    expect(auth.isSignedIn, false);

    // enter correct email and password
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_emailPlaceholder),
        CORRECT_EMAIL + " "); // Check that email is trimmed
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_passwordPlaceholder),
        CORRECT_PASSWORD);
    await tester.pump();
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();

    expect(auth.isSignedIn, true);
  });
}
