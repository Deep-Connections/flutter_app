import 'package:deep_connections/models/question/choice_question.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:deep_connections/screens/question/components/choice_question_widget.dart';
import 'package:deep_connections/models/question/slider_question.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:deep_connections/screens/question/components/choice_question_widget.dart';
import 'package:deep_connections/screens/question/components/slider_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final AnswerNotifier answer;

  const QuestionWidget(
      {super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Text(question.questionText.localize(loc),
            style: Theme.of(context).textTheme.headlineSmall),
        if (question is ChoiceQuestion)
          ChoiceQuestionWidget(
              question: question as ChoiceQuestion, answer: answer)
        else if (question is SliderQuestion)
          SliderQuestionWidget(
              question: question as SliderQuestion, answer: answer)
      ],
    );
  }
}
