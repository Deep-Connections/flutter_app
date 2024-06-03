import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/question/importance.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/question/components/answer_notifier.dart';
import 'package:deep_connections/screens/question/components/importance/importance_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportanceSelectionRow extends StatelessWidget {
  final AnswerNotifier answerNotifier;

  const ImportanceSelectionRow({super.key, required this.answerNotifier});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Text(
          loc.question_importance_howImportant,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: standardPadding),
        ClipRRect(
          borderRadius: BorderRadius.circular(standardPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: spaceChildren(
                Importance.values
                    .map((importance) => ImportanceSelectable(
                          importance: importance,
                          answerNotifier: answerNotifier,
                        ))
                    .toList(),
                2.0),
          ),
        ),
        const SizedBox(height: standardPadding),
      ],
    );
  }
}
