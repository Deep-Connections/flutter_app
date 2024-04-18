import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/screens/chat/components/bubble/bubble.dart';
import 'package:deep_connections/screens/chat/components/bubble/time_stacked_text.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

const innerPadding = 14.0;
const bottomTimePadding = 7.0;
const startPadding = 40.0;
const verticalPadding = 5.0;

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isRight;

  const MessageBubble(
      {super.key, required this.message, required this.isRight});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Bubble(
        isRight: isRight,
        bubbleStartPadding: startPadding,
        bubbleVerticalPadding: verticalPadding,
        child: Padding(
            padding: const EdgeInsets.only(
                left: innerPadding,
                right: innerPadding,
                top: innerPadding,
                bottom: innerPadding - bottomTimePadding),
            child: TimeStackedText(
              text: message.text ?? "",
              style: themeData.textTheme.bodyMedium,
              time: message.timestamp?.toTimeString(context) ?? "",
              timeStyle: themeData.textTheme.labelSmall?.copyWith(
                  color: themeData.colorScheme.onSurface.withOpacity(0.5)),
              bottomTimePadding: bottomTimePadding,
            )));
  }
}
