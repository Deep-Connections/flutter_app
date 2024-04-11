
# Fix dart issues
dart fix --apply

# Builds the injectable files
dart run build_runner build --delete-conflicting-outputs

# run tests
flutter test