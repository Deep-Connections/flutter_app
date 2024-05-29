import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<ElevatedButton> getConfirmationButtons({
  required BuildContext context,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  String? cancelText,
  required String confirmText,
}) =>
    [
      ElevatedButton(
        onPressed: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
        style: cancelElevatedButtonTheme,
        child: Text(cancelText ?? AppLocalizations.of(context).general_cancel),
      ),
      ElevatedButton(
        onPressed: onConfirm?.let((onConfirm) => () {
              onConfirm();
              Navigator.of(context).pop(true);
            }),
        child: Text(confirmText),
      ),
    ];
