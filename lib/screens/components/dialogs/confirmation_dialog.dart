import 'package:deep_connections/screens/components/dialogs/confirmation_buttons.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final BuildContext context;
  final String? titleText;
  final String? contentText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? cancelText;
  final String confirmText;

  const ConfirmationDialog({
    super.key,
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
    return AlertDialog(
      title: titleText != null ? Text(titleText!) : null,
      content: contentText != null ? Text(contentText!) : null,
      actions: getConfirmationButtons(
          context: context,
          onConfirm: onConfirm,
          onCancel: onCancel,
          cancelText: cancelText,
          confirmText: confirmText),
    );
  }
}
