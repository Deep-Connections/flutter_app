import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonAnswers extends StatelessWidget {
  final Profile? profile1;
  final Profile? profile2;

  const CommonAnswers(
      {super.key, required this.profile1, required this.profile2});

  List<QuestionAnswerPair> _findCommonAnswers() {
    print("Recomputing common answers");
    return allQuestionsList.mapNotNull((question) {
      final answer1 = profile1?.questions?[question.id];
      final answer2 = profile2?.questions?[question.id];
      if (answer1 != null && answer2 != null) {
        final commonAnswer = question.findCommonAnswer(answer1, answer2);
        if (commonAnswer != null) {
          return QuestionAnswerPair(question: question, answer: commonAnswer);
        }
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(loc.matchProfile_commonAnswers,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        ..._findCommonAnswers()
            .map(
              (pair) => ListTile(
                  title: Text(pair.question.title.localize(loc)),
                  subtitle: pair.question
                      .localizeAnswer(pair.answer, loc)
                      ?.let((answerText) => Text(answerText))),
            )
            .toList(),
      ],
    );
  }
}

class QuestionAnswerPair {
  final Question question;
  final Answer answer;

  const QuestionAnswerPair({required this.question, required this.answer});
}
