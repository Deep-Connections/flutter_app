import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final Widget? widgetTitle;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final void Function(bool)? onBack;

  const BaseScreen({
    super.key,
    this.title,
    this.widgetTitle,
    required this.body,
    this.actions,
    this.onBack,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final screen = GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
                title: widgetTitle ?? Text(title ?? ""),
                actions: actions,
                leading: leading ??
                    onBack?.let((onBack) => IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => onBack(true),
                        ))),
            body: Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: body,
            ))));
    return screen;
  }
}
