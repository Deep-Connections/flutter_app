import 'package:deep_connections/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateBanner extends StatelessWidget {
  final DateTime? date;

  const DateBanner({super.key, this.date});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date?.toDependingOnDateString(loc, context) ?? "",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
