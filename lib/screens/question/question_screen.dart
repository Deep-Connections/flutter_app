import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:deep_connections/screens/question/components/question_widget.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionScreen extends StatefulWidget {
  final Question question;
  final Stream<Profile?> profileStream;
  final Future<Response<void>> Function(
      Profile Function(Profile profile) transform) updateProfile;
  final LocKey submitText;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.profileStream,
    required this.updateProfile,
    required this.submitText,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final answerNotifier = AnswerNotifier();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: GenericStreamBuilder(
        data: widget.profileStream,
        builder: (context, profile) {
          final initialAnswer = widget.question.fromProfile(profile);
          answerNotifier.answer = initialAnswer;
          return ListenableBuilder(
              listenable: answerNotifier,
              child: Text(widget.question.questionText.localize(loc),
                  style: Theme.of(context).textTheme.headlineSmall),
              builder: (context, child) {
                return DcColumn(children: [
                  if (child != null) child,
                  Expanded(
                      child: QuestionWidget(
                          question: widget.question,
                          answerNotifier: answerNotifier)),
                  ElevatedButton(
                      onPressed: answerNotifier.enabled
                          ? answerNotifier.answer?.let((answer) {
                              if (!widget.question.isAnswerValid(answer)) {
                                return null;
                              }
                              return () async {
                                answerNotifier.enabled = false;
                                await widget.updateProfile((p) =>
                                    widget.question.updateProfile(p, answer));
                                answerNotifier.enabled = true;
                              };
                            })
                          : null,
                      child: Text(widget.submitText.localize(loc)))
                ]);
              });
        },
      ),
    );
  }
}
