import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:deep_connections/screens/question/components/choice_question_widget.dart';
import 'package:deep_connections/screens/question/components/importance/importance_seletion_row.dart';
import 'package:deep_connections/screens/question/components/slider_question_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final AnswerNotifier answerNotifier;

  const QuestionWidget(
      {super.key, required this.question, required this.answerNotifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: switch (question) {
            SliderQuestion() => SliderQuestionWidget(
                question: question as SliderQuestion, answerNotifier: answerNotifier),
            MultipleChoiceQuestion() => ChoiceQuestionWidget(
                question: question as MultipleChoiceQuestion,
                answerNotifier: answerNotifier),
          },
        ),
        ImportanceSelectionRow(answerNotifier: answerNotifier)
      ],
    );
  }
}
