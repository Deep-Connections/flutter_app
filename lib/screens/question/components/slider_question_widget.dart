import 'package:deep_connections/models/question/slider_question.dart';
import 'package:deep_connections/screens/question/components/question_response_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SliderQuestionWidget extends StatefulWidget {
  final SliderQuestion question;
  final QuestionResponseNotifier questionResponse;

  const SliderQuestionWidget(
      {super.key, required this.question, required this.questionResponse});

  @override
  State<SliderQuestionWidget> createState() => _SliderQuestionWidgetState();
}

class _SliderQuestionWidgetState extends State<SliderQuestionWidget> {
  late double sliderValue =
      double.tryParse(widget.questionResponse.values?.firstOrNull ?? "") ??
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
        },
        onChangeEnd: (value) {
          widget.questionResponse.values = [value.toInt().toString()];
        },
      ),
      Text(widget.question.maxText.localize(loc)),
    ]);
  }
}
