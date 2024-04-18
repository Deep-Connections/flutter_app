import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension LetExtension<T> on T {
  /// Extension on nullable types to conditionally perform operations.
  ///
  /// Executes [operation] if the object is not null, passing the object as a parameter,
  /// and returns the result of [operation]. Returns null if the object itself is null.
  ///
  /// Usage:
  /// ```
  /// String? nullableString = "Hello";
  /// nullableString.let((nonNullableString) => print(nonNullableString)); // Prints "Hello"
  /// ```
  ///
  /// - Parameters:
  ///   - [operation]: A function that takes an instance of `T` (the non-nullable version of the nullable type)
  ///     and returns an instance of `R`, where `R` is the desired return type.
  /// - Returns: The result of [operation] if this object is not null; otherwise, null.
  R let<R>(R Function(T it) operation) {
    return operation(this);
  }
}

extension DateTimeExtensions on DateTime {
  String toTimeString() {
    return DateFormat.jm(Intl.getCurrentLocale()).format(this);
  }

  String toDateString() {
    final locale = Intl.getCurrentLocale();
    return DateFormat.yMd(Intl.getCurrentLocale()).format(this);
  }

  String toConDateString(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    return DateFormat.yMd(Intl.getCurrentLocale()).format(this);
  }

  String toWeekdayString() {
    return DateFormat.EEEE(Intl.getCurrentLocale()).format(this);
  }

  bool isSameDay(DateTime? other) {
    if (other == null) return true;
    return year == other.year && month == other.month && day == other.day;
  }

  String toDependingOnDateString(AppLocalizations loc,
      {bool todayAsTime = false, DateTime? now}) {
    DateTime today = now ?? DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime aWeekBefore = today.subtract(const Duration(days: 7));

    if (isSameDay(today)) {
      // If the date is today, return the time or "Today"
      if (todayAsTime) return toTimeString();
      return loc.date_today;
    } else if (isSameDay(yesterday)) {
      // If the date is yesterday, return "Yesterday"
      return loc.date_yesterday;
    } else if (isAfter(aWeekBefore)) {
      // If the date is within the last week, return the weekday
      return toWeekdayString();
    } else {
      // If the date is older than a week, return the date
      return toDateString();
    }
  }
}

extension ListExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T e) test) {
    for (T element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  List<R> mapNotNull<R>(R? Function(T e) transform) {
    List<R> result = [];
    for (T element in this) {
      final transformed = transform(element);
      if (transformed != null) {
        result.add(transformed);
      }
    }
    return result;
  }
}
