import 'package:deep_connections/config/constants.dart';
import 'package:flutter/material.dart';

class MessageBanner extends StatelessWidget {
  final String message;

  const MessageBanner(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: standardPadding / 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: standardPadding / 2, vertical: standardPadding / 4),
          child: Text(
            message,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
