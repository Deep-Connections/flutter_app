import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/chat/components/bubble/notch.dart';
import 'package:flutter/material.dart';

//based on: https://arkapp.medium.com/chat-bubble-widget-for-flutter-95d3bb82ddd8

class Bubble extends StatelessWidget {
  final Widget child;
  final bool isRight;
  final double bubbleStartPadding;
  final double bubbleVerticalPadding;

  const Bubble({
    super.key,
    required this.child,
    this.isRight = true,
    this.bubbleStartPadding = 40.0,
    this.bubbleVerticalPadding = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        isRight ? theme.colorScheme.surface : theme.colorScheme.surfaceVariant;

    final List<Widget> triangleAndCard = [
      SizedBox(width: bubbleStartPadding),
      Flexible(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: maxScreenWidth * 0.6,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topRight: !isRight ? roundedBorderRadius : Radius.zero,
              topLeft: isRight ? roundedBorderRadius : Radius.zero,
              bottomLeft: roundedBorderRadius,
              bottomRight: roundedBorderRadius,
            ),
          ),
          child: child,
        ),
      ),
      CustomPaint(painter: Notch(color)),
    ];

    final messageTextGroup = Row(
      mainAxisAlignment:
          isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: (isRight ? triangleAndCard : triangleAndCard.reversed.toList()),
    );

    return Padding(
      padding: EdgeInsets.only(
          top: bubbleVerticalPadding, bottom: bubbleVerticalPadding),
      child: messageTextGroup,
    );
  }
}
