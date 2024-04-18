import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

extension LocalizedWidgetTester on WidgetTester {
  Future<AppLocalizations> pumpLocalizedWidget(Widget child) async {
    final Key key = UniqueKey();

    await pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('en'),
        home: Container(
          key: key,
          child: child,
        )));
    await pumpAndSettle();

    final BuildContext context = element(find.byKey(key));
    return AppLocalizations.of(context);
  }

  Future<BuildContext> pumpLocalizedWidgetWithContext(Widget child,
      {Locale locale = const Locale('en')}) async {
    final Key key = UniqueKey();

    await pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: Container(
          key: key,
          child: child,
        )));
    await pumpAndSettle();

    final BuildContext context = element(find.byKey(key));
    return context;
  }

  Finder findTextFieldByHintText(String hintText) {
    return find.byWidgetPredicate(
      (Widget widget) =>
          widget is TextField && widget.decoration?.hintText == hintText,
    );
  }

  void checkButtonEnabled(String buttonText, {bool enabled = true}) {
    final ElevatedButton button = widget<ElevatedButton>(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is ElevatedButton &&
            ((widget.child is Text &&
                    (widget.child as Text).data == buttonText) ||
                (widget.child is Row &&
                    (((widget.child as Row).children[0] as Flexible).child
                                as Text)
                            .data ==
                        buttonText)),
        description: "ElevatedButton with text $buttonText not found",
      ),
    );
    expect(button.onPressed != null, enabled);
  }
}
