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
          LocKey((loc) => loc.questionBasic_relationshipType_answer_oneNight),
          confidence: 0.0),
      Choice(
          '2', LocKey((loc) => loc.questionBasic_relationshipType_answer_short),
          confidence: 0.5),
      Choice(
          '3', LocKey((loc) => loc.questionBasic_relationshipType_answer_long),
          confidence: 0.8),
      Choice(
          '4', LocKey((loc) => loc.questionBasic_relationshipType_answer_life),
          confidence: 1),
    ],
    navigationPath: '',
    section: ProfileSection.basic,
  );

  final multipleChoiceQuestion = MultipleChoiceQuestion(
    id: '2',
    questionText: LocKey((loc) => loc.questionBasic_relationshipType_question),
    choices: [
      Choice('1',
          LocKey((loc) => loc.questionBasic_relationshipType_answer_oneNight),
          confidence: 0.0),
      Choice(
          '2', LocKey((loc) => loc.questionBasic_relationshipType_answer_short),
          confidence: 0.1),
      Choice(
          '3', LocKey((loc) => loc.questionBasic_relationshipType_answer_long),
          confidence: 0.3),
      Choice(
          '4', LocKey((loc) => loc.questionBasic_relationshipType_answer_life),
          confidence: 0.6),
    ],
    minChoices: 2,
    maxChoices: 3,
    navigationPath: '',
    section: ProfileSection.basic,
  );

  test("Create answer for single choice question", () {
    final choices = singleChoiceQuestion.choices;
    expect(singleChoiceQuestion.createAnswer([choices[0]]),
        const Answer(choices: ['1'], value: 0.0));
    expect(singleChoiceQuestion.createAnswer([choices[2]]),
        const Answer(choices: ['3'], value: 0.8));
    expect(singleChoiceQuestion.createAnswer([choices[0], choices[1]]), null);
  });

  test("Create answer for multiple choice question", () {
    final choices = multipleChoiceQuestion.choices;
    expect(multipleChoiceQuestion.createAnswer([choices[0]]), null);
    expect(multipleChoiceQuestion.createAnswer(choices), null);
    expect(multipleChoiceQuestion.createAnswer([choices[0], choices[1]]),
        const Answer(choices: ['1', '2'], value: 0.1));
    expect(multipleChoiceQuestion.createAnswer([choices[2], choices[1]]),
        const Answer(choices: ['3', '2'], value: 0.4));
  });

  test("Test isAnswerValid for choice questions", () {
    expect(
        singleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1'], value: 1)),
        true);
    expect(
        singleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1'], value: 0.2)),
        true);
    expect(singleChoiceQuestion.isAnswerValid(const Answer(choices: ['1'])),
        false);
    expect(
        singleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['5'], value: 1)),
        false);
    expect(
        singleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1', '2'], value: 1)),
        false);
    expect(
        singleChoiceQuestion.isAnswerValid(
            const Answer(choices: ['1', '2', '3', '4'], value: 1)),
        false);

    expect(
        multipleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1'], value: 0.2)),
        false);
    expect(
        multipleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1', '2'], value: 0.2)),
        true);
    expect(
        multipleChoiceQuestion.isAnswerValid(const Answer(choices: ['1', '2'])),
        false);
    expect(
        multipleChoiceQuestion.isAnswerValid(
            const Answer(choices: ['1', '2', '3', '4'], value: 0)),
        false);
    expect(
        multipleChoiceQuestion
            .isAnswerValid(const Answer(choices: ['1', '2', '3'], value: 1)),
        true);
  });

  setUp(() {
    navigateSuccess = false;
  });

  testWidgets('Test question screen with single choice question',
      (WidgetTester tester) async {
    // Select answer 3 initially
    profileService = getFakeProfileService();

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
    profileService = getFakeProfileService();

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

    // Initially nothing should be selected, as the answer is invalid
    checkSelected(loc.questionBasic_relationshipType_answer_short, false);
    checkSelected(loc.questionBasic_relationshipType_answer_oneNight, false);
    checkSelected(loc.questionBasic_relationshipType_answer_long, false);
    tester.checkButtonEnabled(loc.general_next, enabled: false);

    // Select answer 1 and 2, check that both are selected
    await tester
        .tap(find.text(loc.questionBasic_relationshipType_answer_oneNight));
    await tester
        .tap(find.text(loc.questionBasic_relationshipType_answer_short));
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

    // select all answers
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
