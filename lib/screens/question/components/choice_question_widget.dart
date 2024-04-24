import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/complete_profile/components/gender_button.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/question/components/question_response_notifier.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoiceQuestionWidget extends StatefulWidget {
  final MultipleChoiceQuestion question;
  final AnswerNotifier answerNotifier;

  const ChoiceQuestionWidget(
      {super.key, required this.question, required this.answerNotifier});

  @override
  State<ChoiceQuestionWidget> createState() => _ChoiceQuestionWidgetState();
}

class _ChoiceQuestionWidgetState extends State<ChoiceQuestionWidget> {
  late List<Choice> selectedAnswers = (widget.answerNotifier.values ?? [])
      .mapNotNull((response) =>
          widget.question.answers.firstWhereOrNull((e) => e.value == response));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(loc.questionType_multipleChoice_numberSelected(
            widget.question.maxChoices, selectedAnswers.length)),
        const SizedBox(height: 10),
        Expanded(
          child: DcListView(
            children: [
              ...widget.question.answers.map((a) => SelectableButton(
                  onPressed: () => _onAnswerPressed(a),
                  selected: selectedAnswers.contains(a),
                  text: a.text.localize(loc)))
            ],
          ),
        ),
      ],
    );
  }

  _onAnswerPressed(Choice a) {
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
      widget.answerNotifier.values = isValidAnswer
          ? selectedAnswers.map((answer) => answer.value).toList()
          : null;
    });
  }
}
