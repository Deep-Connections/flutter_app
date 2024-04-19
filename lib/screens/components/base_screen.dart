import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final Widget? widgetTitle;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final AppBarType? appBarType;

  final void Function(bool)? onBack;

  const BaseScreen({
    super.key,
    this.title,
    this.widgetTitle,
    required this.body,
    this.actions,
    this.onBack,
    this.leading,
    this.appBarType,
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
                backgroundColor:
                    appBarType?.backgroundColor?.call(Theme.of(context)),
                foregroundColor:
                    appBarType?.foregroundColor?.call(Theme.of(context)),
                iconTheme: appBarType?.foregroundColor
                    ?.call(Theme.of(context))
                    .let((color) => IconThemeData(color: color)),
                actions: actions,
                leading: leading ??
                    onBack?.let((onBack) => IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => onBack(true),
                        ))),
            body: Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxScreenWidth),
              child: body,
            ))));
    return screen;
  }
}

sealed class AppBarType {
  final Color Function(ThemeData)? backgroundColor;
  final Color Function(ThemeData)? foregroundColor;

  AppBarType({this.backgroundColor, this.foregroundColor});
}

class AppBarTypeDefault extends AppBarType {}

class AppBarTypeBackground extends AppBarType {
  AppBarTypeBackground()
      : super(
          backgroundColor: (theme) => theme.colorScheme.background,
          foregroundColor: (theme) => theme.colorScheme.onBackground,
        );
}
