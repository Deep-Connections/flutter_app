
# Builds the injectable files
dart run build_runner build --delete-conflicting-outputs

# run tests
flutter test

# Fix dart issues
dart fix --apply