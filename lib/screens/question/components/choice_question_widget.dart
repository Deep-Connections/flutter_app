import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/complete_profile/components/gender_button.dart';
import 'package:deep_connections/screens/components/dc_list_view.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
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
  late List<Choice> selectedChoices =
      (widget.answerNotifier.answer?.choices ?? []).mapNotNull((choice) =>
          widget.question.choices.firstWhereOrNull((c) => c.id == choice));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(loc.questionType_multipleChoice_numberSelected(
            widget.question.maxChoices, selectedChoices.length)),
        const SizedBox(height: 10),
        Expanded(
          child: DcListView(
            children: [
              ...widget.question.choices.map((a) => SelectableButton(
                  onPressed: () => _onChoicePressed(a),
                  selected: selectedChoices.contains(a),
                  text: a.text.localize(loc)))
            ],
          ),
        ),
      ],
    );
  }

  _onChoicePressed(Choice a) {
    setState(() {
      // If the answer is already selected, remove it
      if (selectedChoices.contains(a)) {
        selectedChoices.remove(a);
      } else {
        // For single choice questions we always switch the answer
        if (widget.question.maxChoices == 1) {
          selectedChoices.clear();
          selectedChoices.add(a);
        } else {
          // For multiple choice questions, only add the answer if the max number of choices has not been reached
          if (widget.question.maxChoices > selectedChoices.length) {
            selectedChoices.add(a);
          } else {
            // todo blink or something to show that the max number of choices has been reached
          }
        }
      }
      final isValidAnswer =
          widget.question.minChoices <= selectedChoices.length &&
              selectedChoices.length <= widget.question.maxChoices;
      widget.answerNotifier.answer = isValidAnswer
          ? Answer(
              choices: selectedChoices.map((choice) => choice.id).toList(),
              value: selectedChoices.fold<double>(
                  0.0, (sum, choice) => sum + (choice.gradient ?? 0)))
          : null;
    });
  }
}
