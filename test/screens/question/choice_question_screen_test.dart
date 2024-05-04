import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_profile_service.dart';
import '../../test_extensions.dart';

void main() {
  late bool navigateSuccess;
  late FirebaseProfileService profileService;

  final singleChoiceQuestion = MultipleChoiceQuestion(
    id: '1',
    questionText: LocKey((loc) => loc.questionBasic_relationshipType_question),
    choices: [
      Choice('1',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_oneNight)),
      Choice('2',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_short)),
      Choice(
          '3', LocKey((loc) => loc.questionBasic_relationshipType_answer_long)),
      Choice(
          '4', LocKey((loc) => loc.questionBasic_relationshipType_answer_life)),
    ],
    navigationPath: '',
    section: ProfileSection.basic,
  );

  final multipleChoiceQuestion = MultipleChoiceQuestion(
    id: '2',
    questionText: LocKey((loc) => loc.questionBasic_relationshipType_question),
    choices: [
      Choice('1',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_oneNight)),
      Choice('2',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_short)),
      Choice(
          '3', LocKey((loc) => loc.questionBasic_relationshipType_answer_long)),
      Choice(
          '4', LocKey((loc) => loc.questionBasic_relationshipType_answer_life)),
    ],
    minChoices: 2,
    maxChoices: 3,
    navigationPath: '',
    section: ProfileSection.basic,
  );

  test("Test isAnswerValid for choice questions", () {
    expect(
        singleChoiceQuestion.isAnswerValid(const Answer(choices: ['1'])), true);
    expect(singleChoiceQuestion.isAnswerValid(const Answer(choices: ['5'])),
        false);
    expect(
        singleChoiceQuestion.isAnswerValid(const Answer(choices: ['1', '2'])),
        false);
    expect(
        singleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1', '2', '3', '4'])),
        false);

    expect(multipleChoiceQuestion.isAnswerValid(const Answer(choices: ['1'])),
        false);
    expect(multipleChoiceQuestion.isAnswerValid(const Answer(choices: ['2'])),
        false);
    expect(multipleChoiceQuestion.isAnswerValid(const Answer(choices: ['3'])),
        false);
    expect(multipleChoiceQuestion.isAnswerValid(const Answer(choices: ['4'])),
        false);
    expect(
        multipleChoiceQuestion.isAnswerValid(const Answer(choices: ['1', '2'])),
        true);
    expect(
        multipleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1', '2', '3', '4'])),
        false);
    expect(
        multipleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1', '2', '3'])),
        true);
  });

  setUp(() {
    profileService = getFakeProfileService();
    navigateSuccess = false;
  });

  testWidgets('Test question screen with single choice question',
      (WidgetTester tester) async {
    // Select answer 3 initially
    profileService.updateProfile((p) => p.copyWith(questions: {
          singleChoiceQuestion.id: const Answer(choices: ['3'])
        }));

    // Setup
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: singleChoiceQuestion,
        profileService: profileService,
        onSubmit: () => navigateSuccess = true,
        submitText: LocKey((loc) => loc.general_next)));

    checkSelected(String buttonText, bool selected) {
      final text = selected ? loc.semantic_selected(buttonText) : buttonText;
      expect(find.bySemanticsLabel(text), findsOneWidget);
    }

    checkQuestion(List<String> choices) {
      expect(
          profileService.profile?.questions?[singleChoiceQuestion.id]?.choices,
          choices);
    }

    // Initially 3 should be selected and 1 should not be selected
    checkSelected(loc.questionBasic_relationshipType_answer_long, true);
    checkSelected(loc.questionBasic_relationshipType_answer_oneNight, false);

    // Select answer 1 and check if 3 is not selected anymore
    await tester
        .tap(find.text(loc.questionBasic_relationshipType_answer_oneNight));
    await tester.pumpAndSettle();
    checkSelected(loc.questionBasic_relationshipType_answer_oneNight, true);
    checkSelected(loc.questionBasic_relationshipType_answer_long, false);
    // the complete_profile should still contain 3
    checkQuestion(['3']);
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    checkQuestion(['1']);
  });

  testWidgets('Test question screen with multiple choice question',
      (WidgetTester tester) async {
    // Select answer 2 initially
    profileService.updateProfile((p) => p.copyWith(questions: {
          multipleChoiceQuestion.id: const Answer(choices: ['2'])
        }));

    // Setup
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: multipleChoiceQuestion,
        profileService: profileService,
        onSubmit: () => navigateSuccess = true,
        submitText: LocKey((loc) => loc.general_next)));

    checkSelected(String buttonText, bool selected) {
      final text = selected ? loc.semantic_selected(buttonText) : buttonText;
      expect(find.bySemanticsLabel(text), findsOneWidget);
    }

    checkQuestion(List<String> choices) {
      expect(
          profileService
              .profile?.questions?[multipleChoiceQuestion.id]?.choices,
          choices);
    }

    // Initially 2 should be selected and 1 should not be selected
    checkSelected(loc.questionBasic_relationshipType_answer_short, true);
    checkSelected(loc.questionBasic_relationshipType_answer_oneNight, false);
    checkSelected(loc.questionBasic_relationshipType_answer_long, false);

    // As we have a previous answer, the next button should be enabled,
    // even though we have not selected the minimum number of answers
    tester.checkButtonEnabled(loc.general_next, enabled: true);

    // Select answer 1 and check that both are selected
    await tester
        .tap(find.text(loc.questionBasic_relationshipType_answer_oneNight));
    await tester.pumpAndSettle();
    checkSelected(loc.questionBasic_relationshipType_answer_oneNight, true);
    checkSelected(loc.questionBasic_relationshipType_answer_short, true);
    // the complete_profile should still contain 2
    checkQuestion(['2']);

    // unselect 2 and check that next button is disabled
    await tester
        .tap(find.text(loc.questionBasic_relationshipType_answer_short));
    await tester.pumpAndSettle();
    tester.checkButtonEnabled(loc.general_next, enabled: false);

    // select all 3 answers
    await tester
        .tap(find.text(loc.questionBasic_relationshipType_answer_short));
    await tester.tap(find.text(loc.questionBasic_relationshipType_answer_long));
    await tester.pumpAndSettle();
    await tester.tap(find.text(loc.questionBasic_relationshipType_answer_life));
    await tester.pumpAndSettle();

    // check that all answers are selected except for 4, as we can only select 3
    checkSelected(loc.questionBasic_relationshipType_answer_oneNight, true);
    checkSelected(loc.questionBasic_relationshipType_answer_short, true);
    checkSelected(loc.questionBasic_relationshipType_answer_long, true);
    checkSelected(loc.questionBasic_relationshipType_answer_life, false);

    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    checkQuestion(['1', '2', '3']);
  });
}
