import 'package:deep_connections/models/profile/profile.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/profile/components/gender_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final Profile profile;

  const QuestionWidget(
      {super.key, required this.question, required this.profile});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late List<String> selectedAnswer = [];

  @override
  void initState() {
    super.initState();
    final response = widget.question.fromProfile(widget.profile)?.response;

    if (response != null) {
      selectedAnswer = response;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Text(widget.question.questionText.localize(loc),
            style: Theme.of(context).textTheme.headlineSmall),
        ...widget.question.answers.map((a) => SelectableButton(
            onPressed: () {
              setState(() {
                selectedAnswer = [a.value];
              });
            },
            selected: selectedAnswer.contains(a.value),
            text: a.answerText.localize(loc))),
      ],
    );
  }
}
