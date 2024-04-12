import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  group('DateTimeExtensions', () {
    setUp(() {
      Intl.defaultLocale = 'en_US';
    });

    final loc = AppLocalizationsEn();
    final now = DateTime(2021, 1, 1, 12, 10, 30);

    test(
        'toDependingOnDateString returns time if today and todayAsTime is true',
        () async {
      expect(now.toDependingOnDateString(loc, todayAsTime: true, now: now),
          '12:10 PM');
      await initializeDateFormatting('de_CH', null);
      Intl.defaultLocale = 'de_CH';
      expect(now.toDependingOnDateString(loc, todayAsTime: true, now: now),
          '12:10');
    });

    test(
        'toDependingOnDateString returns "Today" if today and todayAsTime is false',
        () {
      expect(now.toDependingOnDateString(loc, now: now, todayAsTime: false),
          loc.date_today);
    });

    test('toDependingOnDateString returns "Yesterday" for yesterday', () {
      final dateTime = now.subtract(const Duration(days: 1));
      expect(
          dateTime.toDependingOnDateString(loc, now: now), loc.date_yesterday);
    });

    test(
        'toDependingOnDateString returns the weekday if within the last week but not today or yesterday',
        () {
      final dateTime = now.subtract(const Duration(days: 6));
      expect(dateTime.toDependingOnDateString(loc, now: now), "Saturday");
      final dateTime2 = now.subtract(const Duration(days: 3));
      expect(dateTime2.toDependingOnDateString(loc, now: now), "Tuesday");
    });

    test(
        'toDependingOnDateString returns the full date if more than a week ago',
        () {
      final dateTime = now.subtract(const Duration(days: 7));
      expect(dateTime.toDependingOnDateString(loc, now: now), "12/25/2020");
    });
  });
}
