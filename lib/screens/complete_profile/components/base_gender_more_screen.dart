import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BaseGenderMoreScreen extends StatelessWidget {
  final Widget body;
  final Widget? bottom;

  const BaseGenderMoreScreen({super.key, required this.body, this.bottom});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.completeProfile_genderMoreTitle,
        appBarType: AppBarTypeBackground(),
        body: DcColumn(
            children: [Expanded(child: body), if (bottom != null) bottom!]));
  }
}
