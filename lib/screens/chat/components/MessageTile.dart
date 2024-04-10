import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${message.text ?? ""}              \u202F',
              style: themeData.textTheme.bodyMedium,
              textWidthBasis: TextWidthBasis.longestLine,
            ),
            Text(
              message.timestamp?.toHmString() ?? "",
              style: themeData.textTheme.labelSmall?.copyWith(
                  color: themeData.colorScheme.onSurface.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
