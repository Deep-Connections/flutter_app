import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/question/importance.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportanceSelectable extends StatelessWidget {
  final Importance importance;
  final AnswerNotifier answerNotifier;

  const ImportanceSelectable(
      {super.key, required this.importance, required this.answerNotifier});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isSelected = answerNotifier.answer?.importance == importance.value;
    return GestureDetector(
      onTap: () => answerNotifier.importance = importance.value,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: standardPadding / 4, horizontal: standardPadding ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
          ),
          child: Center(
              child: Text(
            importance.label.localize(loc),
            style: theme.textTheme.bodyLarge?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface),
          ))),
    );
  }
}
