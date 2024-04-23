import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/mock_profile_service.dart';
import '../../test_extensions.dart';

void main() {
  late bool navigateSuccess;
  late MockProfileService profileService;

  final question1 = MultipleChoiceQuestion(
    id: '1',
    questionText: LocKey((loc) => loc.question_relationshipType_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_relationshipType_answer1)),
      Answer('2', LocKey((loc) => loc.question_relationshipType_answer2)),
      Answer('3', LocKey((loc) => loc.question_relationshipType_answer3)),
      Answer('4', LocKey((loc) => loc.question_relationshipType_answer4)),
    ],
    navigationPath: '',
    section: ProfileSection.profile,
  );

  setUp(() {
    profileService = MockProfileService();
    navigateSuccess = false;
  });

  testWidgets('Test question screen with single choice question',
      (WidgetTester tester) async {
    // Select answer 3 initially
    profileService.updateProfile((p) => p.copyWith(questions: {
          question1.id: const QuestionResponse(response: ['3'])
        }));

    // Setup
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: question1,
        profileService: profileService,
        onSubmit: () => navigateSuccess = true,
        submitText: LocKey((loc) => loc.general_next)));

    checkSelected(String buttonText, bool selected) {
      final text = selected ? loc.semantic_selected(buttonText) : buttonText;
      expect(find.bySemanticsLabel(text), findsOneWidget);
    }

    checkQuestion(List<String> response) {
      expect(
          profileService.profile?.questions?[question1.id]?.response, response);
    }

    // Initially 3 should be selected and 1 should not be selected
    checkSelected(loc.question_relationshipType_answer3, true);
    checkSelected(loc.question_relationshipType_answer1, false);

    // Select answer 1 and check if 3 is not selected anymore
    await tester.tap(find.text(loc.question_relationshipType_answer1));
    await tester.pumpAndSettle();
    checkSelected(loc.question_relationshipType_answer1, true);
    checkSelected(loc.question_relationshipType_answer3, false);
    // the complete_profile should still contain 3
    checkQuestion(['3']);
    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    checkQuestion(['1']);
  });

  final question2 = MultipleChoiceQuestion(
    id: '2',
    questionText: LocKey((loc) => loc.question_relationshipType_question),
    answers: [
      Answer('1', LocKey((loc) => loc.question_relationshipType_answer1)),
      Answer('2', LocKey((loc) => loc.question_relationshipType_answer2)),
      Answer('3', LocKey((loc) => loc.question_relationshipType_answer3)),
      Answer('4', LocKey((loc) => loc.question_relationshipType_answer4)),
    ],
    minChoices: 2,
    maxChoices: 3,
    navigationPath: '',
    section: ProfileSection.profile,
  );

  testWidgets('Test question screen with multiple choice question',
      (WidgetTester tester) async {
    // Select answer 2 initially
    profileService.updateProfile((p) => p.copyWith(questions: {
          question2.id: const QuestionResponse(response: ['2'])
        }));

    // Setup
    final loc = await tester.pumpLocalizedWidget(QuestionScreen(
        question: question2,
        profileService: profileService,
        onSubmit: () => navigateSuccess = true,
        submitText: LocKey((loc) => loc.general_next)));

    checkSelected(String buttonText, bool selected) {
      final text = selected ? loc.semantic_selected(buttonText) : buttonText;
      expect(find.bySemanticsLabel(text), findsOneWidget);
    }

    checkQuestion(List<String> response) {
      expect(
          profileService.profile?.questions?[question2.id]?.response, response);
    }

    // Initially 2 should be selected and 1 should not be selected
    checkSelected(loc.question_relationshipType_answer2, true);
    checkSelected(loc.question_relationshipType_answer1, false);
    checkSelected(loc.question_relationshipType_answer3, false);

    // As we have a previous answer, the next button should be enabled,
    // even though we have not selected the minimum number of answers
    tester.checkButtonEnabled(loc.general_next, enabled: true);

    // Select answer 1 and check that both are selected
    await tester.tap(find.text(loc.question_relationshipType_answer1));
    await tester.pumpAndSettle();
    checkSelected(loc.question_relationshipType_answer1, true);
    checkSelected(loc.question_relationshipType_answer2, true);
    // the complete_profile should still contain 2
    checkQuestion(['2']);

    // unselect 2 and check that next button is disabled
    await tester.tap(find.text(loc.question_relationshipType_answer2));
    await tester.pumpAndSettle();
    tester.checkButtonEnabled(loc.general_next, enabled: false);

    // select all 3 answers
    await tester.tap(find.text(loc.question_relationshipType_answer2));
    await tester.tap(find.text(loc.question_relationshipType_answer3));
    await tester.pumpAndSettle();
    await tester.tap(find.text(loc.question_relationshipType_answer4));
    await tester.pumpAndSettle();

    // check that all answers are selected except for 4, as we can only select 3
    checkSelected(loc.question_relationshipType_answer1, true);
    checkSelected(loc.question_relationshipType_answer2, true);
    checkSelected(loc.question_relationshipType_answer3, true);
    checkSelected(loc.question_relationshipType_answer4, false);

    await tester.tap(find.text(loc.general_next));
    await tester.pumpAndSettle();
    expect(navigateSuccess, true);
    navigateSuccess = false;
    checkQuestion(['1', '2', '3']);
  });
}
