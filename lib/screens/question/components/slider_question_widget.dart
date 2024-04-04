import 'package:deep_connections/models/question/slider_question.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SliderQuestionWidget extends StatefulWidget {
  final SliderQuestion question;
  final AnswerNotifier answer;

  const SliderQuestionWidget(
      {super.key, required this.question, required this.answer});

  @override
  State<SliderQuestionWidget> createState() => _SliderQuestionWidgetState();
}

class _SliderQuestionWidgetState extends State<SliderQuestionWidget> {
  late double sliderValue =
      double.tryParse(widget.answer.selectedAnswer.firstOrNull.toString()) ??
          widget.question.defaultValue.toDouble();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Row(children: [
      Text(widget.question.minText.localize(loc)),
      Slider.adaptive(
          value: sliderValue,
          min: widget.question.minValue.toDouble(),
          max: widget.question.maxValue.toDouble(),
          divisions: widget.question.divisions,
          onChanged: (value) {
            setState(() {
              sliderValue = value;
            });
            widget.answer.selectedAnswer = [value.toInt().toString()];
          }),
      Text(widget.question.maxText.localize(loc)),
    ]);
  }
}
