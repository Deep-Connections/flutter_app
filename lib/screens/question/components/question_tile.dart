import 'package:deep_connections/models/question/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Text(question.questionText.localize(loc),
            style: Theme.of(context).textTheme.headlineSmall),
        ...question.answers.map((a) => ElevatedButton(
            onPressed: () {}, child: Text(a.answerText.localize(loc))))
      ],
    );
  }
}
