import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnmatchBanner extends StatelessWidget {
  final MessageUnmatch message;

  const UnmatchBanner(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: standardPadding / 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: standardPadding / 2, vertical: standardPadding / 4),
          child: Text(
            loc.messages_unmatchedWithYou(message.senderFirstName),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
