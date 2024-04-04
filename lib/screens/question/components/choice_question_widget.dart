import 'package:deep_connections/models/question/choice_question.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoiceQuestionWidget extends StatelessWidget {
  final MultipleChoiceQuestion question;
  final AnswerNotifier answer;

  const ChoiceQuestionWidget(
      {super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: answer,
      builder: (context, widget) {
        return Column(
          children: [
            ...question.answers.map((a) => SelectableButton(
                onPressed: () {
                  answer.selectedAnswer = [a.value];
                },
                selected: answer.selectedAnswer.contains(a.value),
                text: a.answerText.localize(loc)))
          ],
        );
      },
    );
  }
}
