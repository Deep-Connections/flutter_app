import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/question/components/question_tile.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Question',
        body: DcColumn(
            children: [QuestionWidget(question: relationShipTypeQuestion)]));
  }
}
