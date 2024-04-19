import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompleteProfileCard extends StatelessWidget {
  const CompleteProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Card(
      child: DcColumn(
        children: [
          Text(
            loc.completeProfile_completeDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(loc.completeProfile_completeButton)),
        ],
      ),
    );
  }
}
