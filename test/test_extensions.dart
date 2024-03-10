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

  Finder findTextFieldByHintText(String hintText) {
    return find.byWidgetPredicate(
      (Widget widget) =>
          widget is TextField && widget.decoration?.hintText == hintText,
    );
  }
}
