import 'package:deep_connections/utils/extensions/date_time_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_extensions.dart';

void main() {
  group('DateTimeExtensions', () {
    final loc = AppLocalizationsEn();
    final now = DateTime(2021, 1, 1, 12, 10, 30);

    testWidgets(
        'toDependingOnDateString returns time if today and todayAsTime is true',
        (tester) async {
      final context = await tester.pumpLocalizedWidgetWithContext(
          const SizedBox(),
          locale: const Locale("de"));
      expect(
          now.toDependingOnDateString(loc, context,
              todayAsTime: true, now: now),
          '12:10');
    });

    testWidgets(
        'toDependingOnDateString returns "Today" if today and todayAsTime is false',
        (tester) async {
      final context =
          await tester.pumpLocalizedWidgetWithContext(const SizedBox());
      expect(
          now.toDependingOnDateString(loc, context,
              now: now, todayAsTime: false),
          loc.date_today);
    });

    testWidgets('toDependingOnDateString returns "Yesterday" for yesterday',
        (tester) async {
      final context =
          await tester.pumpLocalizedWidgetWithContext(const SizedBox());
      final dateTime = now.subtract(const Duration(days: 1));
      expect(dateTime.toDependingOnDateString(loc, context, now: now),
          loc.date_yesterday);
    });

    testWidgets(
        'toDependingOnDateString returns the weekday if within the last week but not today or yesterday',
        (tester) async {
      final context =
          await tester.pumpLocalizedWidgetWithContext(const SizedBox());

      final dateTime = now.subtract(const Duration(days: 6));
      expect(
          dateTime.toDependingOnDateString(loc, context, now: now), "Saturday");
      final dateTime2 = now.subtract(const Duration(days: 3));
      expect(
          dateTime2.toDependingOnDateString(loc, context, now: now), "Tuesday");
    });

    testWidgets(
        'toDependingOnDateString returns the full date if more than a week ago',
        (tester) async {
      final context =
          await tester.pumpLocalizedWidgetWithContext(const SizedBox());
      final dateTime = now.subtract(const Duration(days: 7));
      expect(dateTime.toDependingOnDateString(loc, context, now: now),
          "12/25/2020");
    });
  });
}
