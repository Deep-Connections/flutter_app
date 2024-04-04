import 'package:deep_connections/models/question/answer.dart';
import 'package:deep_connections/models/question/choice_question.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:deep_connections/screens/question/components/question_response_notifier.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoiceQuestionWidget extends StatefulWidget {
  final MultipleChoiceQuestion question;
  final QuestionResponseNotifier questionResponse;

  const ChoiceQuestionWidget(
      {super.key, required this.question, required this.questionResponse});

  @override
  State<ChoiceQuestionWidget> createState() => _ChoiceQuestionWidgetState();
}

class _ChoiceQuestionWidgetState extends State<ChoiceQuestionWidget> {
  late List<Answer> selectedAnswers = (widget.questionResponse.values ?? [])
      .mapNotNull((response) =>
          widget.question.answers.firstWhereOrNull((e) => e.value == response));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        ...widget.question.answers.map((a) => SelectableButton(
            onPressed: () => _onAnswerPressed(a),
            selected: selectedAnswers.contains(a),
            text: a.answerText.localize(loc)))
      ],
    );
  }

  _onAnswerPressed(Answer a) {
    setState(() {
      // If the answer is already selected, remove it
      if (selectedAnswers.contains(a)) {
        selectedAnswers.remove(a);
      } else {
        // For single choice questions we always switch the answer
        if (widget.question.maxChoices == 1) {
          selectedAnswers.clear();
          selectedAnswers.add(a);
        } else {
          // For multiple choice questions, only add the answer if the max number of choices has not been reached
          if (widget.question.maxChoices > selectedAnswers.length) {
            selectedAnswers.add(a);
          } else {
            // todo blink or something to show that the max number of choices has been reached
          }
        }
      }
      final isValidAnswer =
          widget.question.minChoices <= selectedAnswers.length &&
              selectedAnswers.length <= widget.question.maxChoices;
      widget.questionResponse.values = isValidAnswer
          ? selectedAnswers.map((answer) => answer.value).toList()
          : null;
    });
  }
}
