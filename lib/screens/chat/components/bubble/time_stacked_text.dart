import 'package:flutter/material.dart';

class TimeStackedText extends StatelessWidget {
  final String text;
  final String time;
  final TextStyle? style;
  final TextStyle? timeStyle;
  final double bottomTimePadding;

  const TimeStackedText(
      {super.key,
      required this.text,
      required this.time,
      this.style,
      this.timeStyle,
      this.bottomTimePadding = 8.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: bottomTimePadding),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: "$text   ", style: style),

                //space for time
                TextSpan(
                    text: time,
                    style: (timeStyle ?? const TextStyle(inherit: true))
                        .copyWith(color: Colors.transparent)),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Text(
            time,
            style: timeStyle,
          ),
        )
      ],
    );
  }
}
