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
  String toHmString() {
    return DateFormat.Hm(Intl.getCurrentLocale()).format(this);
  }

  String toYmdString() {
    return DateFormat.yMd(Intl.getCurrentLocale()).format(this);
  }
}

extension ListExtensions<T> on List<T> {
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
