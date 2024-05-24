import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/dialogs/confirmation_dialog.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileSettingsScreen extends StatelessWidget {
  final AuthService authService;

  const ProfileSettingsScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.profileSettings_title,
        body: DcColumn(children: [
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(loc.profileSettings_logoutButton),
            onTap: () => authService.signOut(),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: Text(loc.profileSettings_deleteAccountButton),
            onTap: () => showDialog(
              context: context,
              builder: (context) => ConfirmationDialog(
                context: context,
                titleText: loc.profileSettings_deleteAccountDialogTitle,
                contentText: loc.profileSettings_deleteAccountDialogContent,
                onConfirm: () async {
                  await authService.deleteAccount();
                },
                confirmText: loc.profileSettings_deleteAccountButton,
              ),
            ),
          ),
        ]));
  }
}
