import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/screens/chat/components/bubble/bubble.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

const bubblePadding = 10.0;

class MessageTile extends StatelessWidget {
  final Message message;
  final bool isRight;

  const MessageTile({super.key, required this.message, required this.isRight});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Bubble(
      isRight: isRight,
      child: Padding(
        padding: const EdgeInsets.only(
            left: bubblePadding,
            right: bubblePadding,
            top: bubblePadding,
            bottom: bubblePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${message.text ?? ""}              \u202F',
              style: themeData.textTheme.bodyMedium,
              textWidthBasis: TextWidthBasis.longestLine,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.timestamp?.toHmString() ?? "",
                style: themeData.textTheme.labelSmall?.copyWith(
                    color: themeData.colorScheme.onSurface.withOpacity(0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
