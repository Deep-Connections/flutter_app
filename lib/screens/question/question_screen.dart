import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/future_builder.dart';
import 'package:deep_connections/screens/question/components/question_widget.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  final Question question;
  final void Function() navigate;
  final ProfileService profileService;

  const QuestionScreen(
      {super.key,
      required this.question,
      required this.navigate,
      required this.profileService});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Question',
        body: GenericFutureBuilder(
          data: profileService.profile,
          builder: (context, profile) {
            return DcColumn(children: [
              QuestionWidget(question: question, profile: profile),
              ElevatedButton(onPressed: navigate, child: const Text('Next'))
            ]);
          },
        ));
  }
}
