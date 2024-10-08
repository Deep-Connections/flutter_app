import 'dart:async';

import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/screens/complete_profile/gender/gender_profile_screen.dart';
import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_profile_service.dart';
import '../../test_extensions.dart';

void main() {
  late bool navigateSuccess;
  late FirebaseProfileService profileService;

  setUp(() {
    profileService = getFakeProfileService();
    navigateSuccess = false;
    expect(profileService.profile?.gender, null);
  });


  testWidgets('Test complete_profile screen selecting male and female',
      (WidgetTester tester) async {
    // Setup
    final completer = Completer();
    final loc = await tester.pumpLocalizedWidget(GenderProfileScreen(
        profileStream: profileService.profileStream,
        submitText: LocKey((loc) => loc.general_next),
        updateProfile: (transformation) async {
          await completer.future;
          final response = await profileService.updateProfile(transformation);
          navigateSuccess = true;
          return response;
        }));

    tester.checkElevatedButtonEnabled(loc.general_next, enabled: true);
    tester.checkSelectableButtonEnabled(loc.input_genderEnumWoman,
        enabled: true);
    tester.checkSelectableButtonEnabled(loc.input_genderEnumMan, enabled: true);
    tester.checkSelectableButtonEnabled(loc.completeProfile_genderMore,
        enabled: true);

    await tester.tap(find.text(loc.input_genderEnumWoman));
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();

    // Check disabling of buttons during request
    expect(navigateSuccess, false);
    tester.checkElevatedButtonEnabled(loc.general_next, enabled: false);
    tester.checkSelectableButtonEnabled(loc.input_genderEnumWoman,
        enabled: false);
    tester.checkSelectableButtonEnabled(loc.input_genderEnumMan,
        enabled: false);
    tester.checkSelectableButtonEnabled(loc.completeProfile_genderMore,
        enabled: false);

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
    final loc = await tester.pumpLocalizedWidget(GenderProfileScreen(
        profileStream: profileService.profileStream,
        submitText: LocKey((loc) => loc.general_next),
        updateProfile: (transformation) async {
          final response = await profileService.updateProfile(transformation);
          navigateSuccess = true;
          return response;
        }));

    // open more and select non-binary
    await tester.tap(find.text(loc.completeProfile_genderMore));
    await tester.pumpAndSettle();
    await tester.tap(find.text(loc.input_genderEnumNonBinary));
    await tester.tap(find.text(loc.general_submit));
    await tester.pumpAndSettle();

    // Check that instead of more we show non-binary
    expect(find.text(loc.completeProfile_genderMore), findsNothing);
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
    await tester.tap(find.text(loc.general_submit));
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
    tester.increaseScreenSize();
    final loc = await tester.pumpLocalizedWidget(GenderProfileScreen(
        profileStream: profileService.profileStream,
        submitText: LocKey((loc) => loc.general_next),
        updateProfile: (transformation) async {
          final response = await profileService.updateProfile(transformation);
          navigateSuccess = true;
          return response;
        }));

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
    await tester.tap(find.text(loc.general_submit));
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
    await tester.tap(find.text(loc.general_submit));
    await tester.pumpAndSettle();

    // check that we are back in the complete_profile screen
    expect(find.text(loc.input_genderError), findsNothing);
    expect(find.text(customGender), findsOneWidget);
    expect(find.text(loc.completeProfile_genderTitle), findsOneWidget);

    // Hit next and check that custom gender is sent to the backend
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    expect(profileService.profile?.gender, Gender.other.enumValue);
    expect(profileService.profile?.customGender, customGender);
  });
}
