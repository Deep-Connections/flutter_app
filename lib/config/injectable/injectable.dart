import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

String getEnvironment() {
  if (kReleaseMode) return Environment.prod;

  // to run with the emulator: flutter run --dart-define=FIREBASE_EMULATOR=true
  String? isFirebaseEmulator =
      const String.fromEnvironment('FIREBASE_EMULATOR');

  if (isFirebaseEmulator == "true") {
    return Environment.dev;
  } else {
    return Environment.prod;
  }
}

@InjectableInit()
void configureDependencies(String environment) =>
    getIt.init(environment: environment);
