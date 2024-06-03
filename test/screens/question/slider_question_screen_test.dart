import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_profile_service.dart';
import '../../test_extensions.dart';

void main() {
  late bool navigateSuccess;
  late FirebaseProfileService profileService;

  final oddDivisionQuestion = SliderQuestion(
    id: '1',
    questionText: LocKey((loc) => loc.questionPolitics_spectrum_question),
    divisions: 5,
    minText: LocKey((loc) => loc.questionPolitics_spectrum_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_spectrum_answerMax),
    middleText: LocKey((loc) => loc.questionPolitics_spectrum_answerMiddle),
    navigationPath: '',
    section: ProfileSection.basic,
  );

  final evenDivisionQuestion = SliderQuestion(
    id: '2',
    questionText: LocKey((loc) => loc.questionPolitics_spectrum_question),
    minText: LocKey((loc) => loc.questionPolitics_spectrum_answerMin),
    maxText: LocKey((loc) => loc.questionPolitics_spectrum_answerMax),
    divisions: 6,
    navigationPath: '',
    section: ProfileSection.basic,
  );

  test("Test isAnswerValid for slider questions", () {
    expect(oddDivisionQuestion.isAnswerValid(const Answer(confidence: 0.01)),
        true);
    expect(
        oddDivisionQuestion.isAnswerValid(const Answer(confidence: 0.0)), true);
    expect(
        oddDivisionQuestion.isAnswerValid(const Answer(confidence: 1.0)), true);
    expect(oddDivisionQuestion.isAnswerValid(const Answer(confidence: -1.0)),
        false);
    expect(oddDivisionQuestion.isAnswerValid(const Answer(confidence: 2.0)),
        false);
    expect(evenDivisionQuestion.isAnswerValid(const Answer(confidence: 0.01)),
        true);
    expect(evenDivisionQuestion.isAnswerValid(const Answer(confidence: 0.5)),
        true);
    expect(evenDivisionQuestion.isAnswerValid(const Answer(confidence: 0.0)),
        true);
    expect(evenDivisionQuestion.isAnswerValid(const Answer(confidence: 1.0)),
        true);
    expect(evenDivisionQuestion.isAnswerValid(const Answer(confidence: -1.0)),
        false);
    expect(evenDivisionQuestion.isAnswerValid(const Answer(confidence: 2.0)),
        false);
  });

  setUp(() {
    profileService = getFakeProfileService();
    navigateSuccess = false;
  });

  testWidgets('Test slider question with 5 divisions',
      (WidgetTester tester) async {
    expect(oddDivisionQuestion.defaultValue, 0.5);
    // Setup
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: oddDivisionQuestion,
        profileStream: profileService.profileStream,
        updateProfile: (transformation) async {
          final response = await profileService.updateProfile(transformation);
          navigateSuccess = true;
          return response;
        },
        submitText: LocKey((loc) => loc.general_next)));

    // Check next disabled in the beginning
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, false);

    checkSelected(double selected) async {
      await tester.tap(find.text(loc.general_next));
      await tester.pumpAndSettle();
      expect(navigateSuccess, true);
      navigateSuccess = false;
      expect(
          profileService
              .profile?.questions?[oddDivisionQuestion.id]?.confidence,
          selected);
    }

    await tester.drag(find.byType(Slider), const Offset(300, 0));
    await tester.pumpAndSettle();
    await checkSelected(1.0);

    await tester.drag(find.byType(Slider), const Offset(-100, 0));
    await tester.pumpAndSettle();
    await checkSelected(0.25);
  });

  testWidgets('Test slider question with 6 divisions',
      (WidgetTester tester) async {
    expect(evenDivisionQuestion.defaultValue, 0.4);

    // Setup
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: evenDivisionQuestion,
        profileStream: profileService.profileStream,
        updateProfile: (transformation) async {
          final response = await profileService.updateProfile(transformation);
          navigateSuccess = true;
          return response;
        },
        submitText: LocKey((loc) => loc.general_next)));

    // Check next disabled in the beginning
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, false);

    checkSelected(double selected) async {
      await tester.tap(find.text(loc.general_next));
      await tester.pumpAndSettle();
      expect(navigateSuccess, true);
      navigateSuccess = false;
      expect(
          profileService
              .profile?.questions?[evenDivisionQuestion.id]?.confidence,
          selected);
    }

    await tester.drag(find.byType(Slider), const Offset(-300, 0));
    await tester.pumpAndSettle();
    await checkSelected(0.0);

    await tester.drag(find.byType(Slider), const Offset(20, 0));
    await tester.pumpAndSettle();
    await checkSelected(0.6);
  });
}
