import 'package:deep_connections/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationDialog extends StatelessWidget {
  final BuildContext context;
  final String? titleText;
  final String? contentText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? cancelText;
  final String confirmText;

  const ConfirmationDialog({super.key,
    required this.context,
    this.titleText,
    this.contentText,
    this.onConfirm,
    this.onCancel,
    this.cancelText,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      title: titleText != null ? Text(titleText!) : null,
      content: contentText != null ? Text(contentText!) : null,
      actions: [
        ElevatedButton(
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop(false);
          },
          style: cancelElevatedButtonTheme,
          child: Text(cancelText ?? loc.general_cancel),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}
