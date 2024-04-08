import 'dart:async';

import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/complete_profile/gender/gender_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_profile_service.dart';
import '../../test_extensions.dart';

void main() {
  late bool navigateSuccess;
  late MockProfileService profileService;

  setUp(() {
    profileService = MockProfileService();
    navigateSuccess = false;
    expect(profileService.profile?.gender, null);
  });

  checkButtonEnabled(String buttonText, WidgetTester tester,
      {bool enabled = true}) {
    final ElevatedButton button = tester.widget<ElevatedButton>(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is ElevatedButton &&
            ((widget.child is Text &&
                    (widget.child as Text).data == buttonText) ||
                (widget.child is Row &&
                    (((widget.child as Row).children[0] as Flexible).child
                                as Text)
                            .data ==
                        buttonText)),
        description: "ElevatedButton with text $buttonText not found",
      ),
    );
    expect(button.onPressed != null, enabled);
  }

  testWidgets('Test complete_profile screen selecting male and female',
      (WidgetTester tester) async {
    // Setup
    final completer = Completer();
    profileService.profile = const Profile();
    final loc = await tester.pumpLocalizedWidget(GenderProfileScreen(
        profileService: profileService,
        navigateToNext: () async {
          await completer.future;
          navigateSuccess = true;
        }));

    checkButtonEnabled(loc.general_next, tester, enabled: true);
    checkButtonEnabled(loc.input_genderEnumWoman, tester, enabled: true);
    checkButtonEnabled(loc.input_genderEnumMan, tester, enabled: true);
    checkButtonEnabled(loc.profile_genderMore, tester, enabled: true);

    await tester.tap(find.text(loc.input_genderEnumWoman));
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();

    // Check disabling of buttons during request
    expect(navigateSuccess, false);
    checkButtonEnabled(loc.general_next, tester, enabled: false);
    checkButtonEnabled(loc.input_genderEnumWoman, tester, enabled: false);
    checkButtonEnabled(loc.input_genderEnumMan, tester, enabled: false);
    checkButtonEnabled(loc.profile_genderMore, tester, enabled: false);

    completer.complete();
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    expect(profileService.profile?.gender, Gender.woman.enumValue);

    await tester.tap(find.text(loc.input_genderEnumMan));
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    expect(profileService.profile?.gender, Gender.man.enumValue);
  });

  testWidgets('Test complete_profile screen selecting additional genders',
      (WidgetTester tester) async {
    // Setup
    profileService.profile = const Profile();
    final loc = await tester.pumpLocalizedWidget(GenderProfileScreen(
        profileService: profileService,
        navigateToNext: () async => navigateSuccess = true));

    // open more and select non-binary
    await tester.tap(find.text(loc.profile_genderMore));
    await tester.pumpAndSettle();
    await tester.tap(find.text(loc.input_genderEnumNonBinary));
    await tester.tap(find.text(loc.general_submitButton));
    await tester.pumpAndSettle();

    // Check that instead of more we show non-binary
    expect(find.text(loc.profile_genderMore), findsNothing);
    expect(find.text(loc.input_genderEnumNonBinary), findsOneWidget);

    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    expect(profileService.profile?.gender, Gender.nonBinary.enumValue);

    // Now we need to press non-binary to go to more
    await tester.tap(find.text(loc.input_genderEnumNonBinary));
    await tester.pumpAndSettle();
    // Select trans woman
    await tester.tap(find.text(loc.input_genderEnumTransWoman));
    await tester.tap(find.text(loc.general_submitButton));
    await tester.pumpAndSettle();
    // Check that instead of more we show non-binary
    expect(find.text(loc.input_genderEnumTransWoman), findsOneWidget);

    // Check that trans woman sent to backend instead of non-binary
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    expect(profileService.profile?.gender, Gender.transWoman.enumValue);
  });

  testWidgets('Test complete_profile screen type in genders',
      (WidgetTester tester) async {
    // initially non-binary is already selected
    await profileService
        .updateProfile((p) => p.copyWith(gender: Gender.nonBinary.enumValue));

    // Setup
    final loc = await tester.pumpLocalizedWidget(GenderProfileScreen(
        profileService: profileService,
        navigateToNext: () async => navigateSuccess = true));

    // Now we need to press non-binary to go to more
    await tester.tap(find.text(loc.input_genderEnumNonBinary));
    await tester.pumpAndSettle();
    // Input invalid gender shows error
    const customInvalidGender = "MyGender'";
    await tester
        .tap(tester.findTextFieldByHintText(loc.input_genderPlaceholder));
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_genderPlaceholder),
        customInvalidGender);
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -50));
    await tester.pumpAndSettle();
    await tester.tap(find.text(loc.general_submitButton));
    await tester.pumpAndSettle();
    expect(find.text(loc.input_genderError), findsOneWidget);

    // Input valid gender goes back
    const customGender = "MmÜ ü-ä"; // Letters, space and dash should be allowed
    await tester
        .tap(tester.findTextFieldByHintText(loc.input_genderPlaceholder));
    await tester.enterText(
        tester.findTextFieldByHintText(loc.input_genderPlaceholder),
        " $customGender "); // check that it is trimmed
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -50));
    await tester.pumpAndSettle();
    await tester.tap(find.text(loc.general_submitButton));
    await tester.pumpAndSettle();

    // check that we are back in the complete_profile screen
    expect(find.text(loc.input_genderError), findsNothing);
    expect(find.text(customGender), findsOneWidget);
    expect(find.text(loc.profile_genderTitle), findsOneWidget);

    // Hit next and check that custom gender is sent to the backend
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    expect(profileService.profile?.gender, customGender);
  });
}
