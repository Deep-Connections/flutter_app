import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/future_builder.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:deep_connections/screens/question/components/question_widget.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionScreen extends StatefulWidget {
  final Question question;
  final void Function() navigate;
  final ProfileService profileService;

  const QuestionScreen(
      {super.key,
      required this.question,
      required this.navigate,
      required this.profileService});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final answerNotifier = AnswerNotifier();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: 'Question',
        body: GenericFutureBuilder(
          data: widget.profileService.profile,
          builder: (context, profile) {
            final initialAnswer =
                widget.question.fromProfile(profile)?.response ?? [];
            answerNotifier.selectedAnswer = initialAnswer;
            return DcColumn(children: [
              QuestionWidget(question: widget.question, answer: answerNotifier),
              ElevatedButton(
                  onPressed: () => widget.profileService.updateProfile((p) =>
                      widget.question.updateProfile(
                          p,
                          QuestionResponse(
                              response: answerNotifier.selectedAnswer))),
                  child: Text(loc.general_submitButton))
            ]);
          },
        ));
  }
}
