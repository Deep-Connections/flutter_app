

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
extension LetExtension<T> on T? {
  R? let<R>(R Function(T it) operation) {
    if (this != null) {
      return operation(this!);
    }
    return null;
  }
}