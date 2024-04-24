import 'package:deep_connections/screens/auth/registration_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_auth_service.dart';
import '../../test_extensions.dart';

void main() {
  testWidgets('Test registration screen with wrong and correct credentials ',
      (WidgetTester tester) async {
    final auth = MockAuthService();
    var registerSuccess = false;

    final loc = await tester.pumpLocalizedWidget(RegistrationScreen(
        auth: auth, onRegisterSuccess: () async => registerSuccess = true));
    expect(find.text(loc.register_title), findsOneWidget);
    expect(find.text(loc.auth_emailInvalidError), findsNothing);
    expect(find.text(loc.login_wrongCredentialsError), findsNothing);

    // click login button without entering anything
    await tester.tap(find.text(loc.register_registerButton));
    await tester.pumpAndSettle();
    expect(find.text(loc.auth_emailInvalidError), findsOneWidget);
    expect(find.text(loc.auth_passwordNoneError), findsOneWidget);

    expect(find.text(loc.input_emailPlaceholder), findsOneWidget);
    expect(find.text(loc.input_passwordPlaceholder), findsOneWidget);

    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_emailPlaceholder),
        'example@email.com');

    checkPasswordError(String password, String expectedError) async {
      await tester.enterText(
          tester.findTextFieldByHintText(loc.input_passwordPlaceholder),
          password);
      await tester.pump();
      await tester.tap(find.text(loc.register_registerButton));
      await tester.pumpAndSettle();
      expect(find.text(expectedError), findsOneWidget,
          reason:
              "When submitting password=$password there was no error with the text=$expectedError)");
      expect(auth.isRegistered, false);
      expect(registerSuccess, false);
    }

    await checkPasswordError("short", loc.auth_passwordLengthError);
    await checkPasswordError("PasswordNoNumber", loc.auth_passwordNumberError);
    await checkPasswordError(
        "no_upper_case_pw1", loc.auth_passwordUppercaseError);
    await checkPasswordError(
        "NO_LOWER_CASE_PW2", loc.auth_passwordLowercaseError);

    // enter valid and password
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_passwordPlaceholder),
        correctPassword);
    await tester.pump();
    await tester.tap(find.text(loc.register_registerButton));
    await tester.pumpAndSettle();

    expect(auth.isRegistered, true);
    expect(registerSuccess, true);
  });
}
