import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProfileSectionScreen extends StatelessWidget {
  final ProfileSection section;

  const ProfileSectionScreen({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: section.title.localize(loc),
        body: ListView(
            padding: const EdgeInsets.all(standardPadding),
            children: allProfileStepList
                .where((step) => step.section == section && step.isEditable)
                .map(
                  (step) => ListTile(
                    title: Text(step.title.localize(loc),
                        style: Theme.of(context).textTheme.bodyMedium),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.go(ProfileRoutes.step.parameterPath(
                        [step.section.path, step.navigationPath])),
                  ),
                )
                .toList()));
  }
}
