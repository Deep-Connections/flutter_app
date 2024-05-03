import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

String _getLocale(BuildContext context) {
  final locale =
      Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US');
  final countryCode = locale.countryCode;
  return locale.languageCode + (countryCode != null ? '_$countryCode' : '');
}

extension DateTimeExtensions on DateTime {
  String toTimeString(BuildContext context) {
    final prefer24hFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    if (prefer24hFormat) {
      return DateFormat.Hm(_getLocale(context)).format(this);
    }
    return DateFormat.jm(_getLocale(context)).format(this);
  }

  String toDateString(BuildContext context) {
    return DateFormat.yMd(_getLocale(context)).format(this);
  }

  String toWeekdayString(BuildContext context) {
    return DateFormat.EEEE(_getLocale(context)).format(this);
  }

  bool isSameDay(DateTime? other) {
    if (other == null) return true;
    return year == other.year && month == other.month && day == other.day;
  }

  String toDependingOnDateString(AppLocalizations loc, BuildContext context,
      {bool todayAsTime = false, DateTime? now}) {
    DateTime today = now ?? DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime aWeekBefore = today.subtract(const Duration(days: 7));

    if (isSameDay(today)) {
      // If the date is today, return the time or "Today"
      if (todayAsTime) return toTimeString(context);
      return loc.date_today;
    } else if (isSameDay(yesterday)) {
      // If the date is yesterday, return "Yesterday"
      return loc.date_yesterday;
    } else if (isAfter(aWeekBefore)) {
      // If the date is within the last week, return the weekday
      return toWeekdayString(context);
    } else {
      // If the date is older than a week, return the date
      return toDateString(context);
    }
  }
}
