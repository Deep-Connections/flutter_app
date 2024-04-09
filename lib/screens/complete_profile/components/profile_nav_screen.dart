import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileNavScreen extends StatelessWidget {
  final ProfileNavigationStep navigationStep;
  final void Function(bool)? navigatePrevious;
  final Widget body;

  const ProfileNavScreen(
      {super.key,
      required this.navigationStep,
      this.navigatePrevious,
      required this.body});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: navigationStep.section.title.localize(loc),
        onBack: navigatePrevious,
        body: body);
  }
}
