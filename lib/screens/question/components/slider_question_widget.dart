import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/components/question_response_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SliderQuestionWidget extends StatelessWidget {
  final SliderQuestion question;
  final AnswerNotifier answerNotifier;

  const SliderQuestionWidget(
      {super.key, required this.question, required this.answerNotifier});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(standardPadding),
                child: Text(question.minText.localize(loc),
                    textAlign: TextAlign.left),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(standardPadding),
                child: Text(question.maxText.localize(loc),
                    textAlign: TextAlign.right),
              ),
            )
          ],
        ),
        Row(children: [
          Expanded(
            child: QuestionSlider(
                question: question, answerNotifier: answerNotifier),
          ),
        ]),
      ],
    );
  }
}

class QuestionSlider extends StatefulWidget {
  final SliderQuestion question;
  final AnswerNotifier answerNotifier;

  const QuestionSlider(
      {super.key, required this.question, required this.answerNotifier});

  @override
  State<QuestionSlider> createState() => _QuestionSliderState();
}

class _QuestionSliderState extends State<QuestionSlider> {
  late double sliderValue =
      double.tryParse(widget.answerNotifier.values?.firstOrNull ?? "") ??
          widget.question.defaultValue.toDouble();

  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
      value: sliderValue,
      min: widget.question.minValue.toDouble(),
      max: widget.question.maxValue.toDouble(),
      divisions: widget.question.divisions,
      onChanged: (value) {
        setState(() {
          sliderValue = value;
        });
      },
      onChangeEnd: (value) {
        widget.answerNotifier.values = [value.toInt().toString()];
      },
    );
  }
}
