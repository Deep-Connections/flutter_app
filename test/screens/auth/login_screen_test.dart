import 'package:deep_connections/screens/auth/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_auth_service.dart';
import '../../test_extensions.dart';

void main() {
  testWidgets('Login screen test ', (WidgetTester tester) async {
    final auth = MockAuthService();

    final loc = await tester
        .pumpLocalizedWidget(LoginScreen(navigateRegister: () {}, auth: auth));
    expect(find.text(loc.login_title), findsOneWidget);
    expect(find.text(loc.input_emailValidError), findsNothing);
    expect(find.text(loc.input_passwordLengthError), findsNothing);

    // click login button without entering anything
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();
    expect(find.text(loc.input_emailValidError), findsOneWidget);
    expect(find.text(loc.input_passwordLengthError), findsOneWidget);

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

    // todo check that error message is shown
    expect(auth.isSignedIn, false);

    // enter correct email and password
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_emailPlaceholder),
        CORRECT_EMAIL);
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_passwordPlaceholder),
        CORRECT_PASSWORD);
    await tester.pump();
    await tester.tap(find.text(loc.login_loginButton));
    await tester.pumpAndSettle();

    expect(auth.isSignedIn, true);
  });
}
