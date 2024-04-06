import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/slider_question.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_profile_service.dart';
import '../../test_extensions.dart';

void main() {
  late bool navigateSuccess;
  late MockProfileService profileService;

  final question1 = SliderQuestion(
    id: '1',
    questionText: LocKey((loc) => loc.question_politicalSpectrum_question),
    minValue: 1,
    maxValue: 5,
    minText: LocKey((loc) => loc.question_politicalSpectrum_answerMin),
    maxText: LocKey((loc) => loc.question_politicalSpectrum_answerMax),
    fromProfile: (p) => p.question1,
    updateProfile: (p, r) => p.copyWith(question1: r),
    navigationPath: '',
  );

  setUp(() {
    profileService = MockProfileService();
    navigateSuccess = false;
  });

  testWidgets('Test question screen with slider question',
      (WidgetTester tester) async {
    // Setup
    profileService.profile = const Profile();
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: question1,
        profileService: profileService,
        navigate: () => navigateSuccess = true));

    // Check next disabled in the beginning
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, false);

    checkSelected(int selected) async {
      await tester.tap(find.text(loc.general_next));
      await tester.pumpAndSettle();
      expect(navigateSuccess, true);
      navigateSuccess = false;
      expect(
          profileService.profile?.question1?.response, [selected.toString()]);
    }

    await tester.drag(find.byType(Slider), const Offset(100, 0));
    await tester.pumpAndSettle();
    await checkSelected(5);

    await tester.drag(find.byType(Slider), const Offset(-50, 0));
    await tester.pumpAndSettle();
    await checkSelected(2);
  });

  final question2 = SliderQuestion(
    id: '1',
    questionText: LocKey((loc) => loc.question_politicalSpectrum_question),
    minValue: -1,
    maxValue: 4,
    minText: LocKey((loc) => loc.question_politicalSpectrum_answerMin),
    maxText: LocKey((loc) => loc.question_politicalSpectrum_answerMax),
    fromProfile: (p) => p.question2,
    updateProfile: (p, r) => p.copyWith(question2: r),
    navigationPath: '',
  );

  testWidgets('Test question screen with slider with negative value',
      (WidgetTester tester) async {
    // Setup
    profileService.profile = const Profile();
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: question2,
        profileService: profileService,
        navigate: () => navigateSuccess = true));

    // Check next disabled in the beginning
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, false);

    checkSelected(int selected) async {
      await tester.tap(find.text(loc.general_next));
      await tester.pumpAndSettle();
      expect(navigateSuccess, true);
      navigateSuccess = false;
      expect(
          profileService.profile?.question2?.response, [selected.toString()]);
    }

    await tester.drag(find.byType(Slider), const Offset(-100, 0));
    await tester.pumpAndSettle();
    await checkSelected(-1);

    await tester.drag(find.byType(Slider), const Offset(-20, 0));
    await tester.pumpAndSettle();
    await checkSelected(1);
  });
}
