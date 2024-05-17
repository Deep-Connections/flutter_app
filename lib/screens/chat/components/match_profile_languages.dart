import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/utils/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchProfileLanguages extends StatelessWidget {
  final Profile? matchProfile;

  const MatchProfileLanguages({super.key, this.matchProfile});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(standardPadding),
        child: Column(
          children: [
            Text(
                loc.matchProfile_languages(combinedLanguageText(
                    context, matchProfile?.languageWithCountryCodes)),
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center)
          ],
        ));
  }
}