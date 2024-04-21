import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/profile/step/profile_step_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProfileSectionStepScreen extends StatelessWidget {
  final ProfileNavigationStep step;

  const ProfileSectionStepScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: step.section.title.localize(loc),
        body: ProfileStepWidget(
          step: step,
          navigateToNext: () async => context.pop(),
        ));
  }
}
