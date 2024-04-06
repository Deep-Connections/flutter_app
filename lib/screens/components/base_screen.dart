import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final Widget body;
  final bool showBackButton;
  final List<Widget>? actions;

  const BaseScreen({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title ?? ""),
            actions: actions,
            automaticallyImplyLeading: showBackButton,
          ),
          body: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: body)),
        ));
  }
}
