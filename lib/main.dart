import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/firebase_options.dart';
import 'package:deep_connections/navigation/graphs/main_nav_graph.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'config/constants.dart';
import 'config/injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    // Only for debug mode.
    try {
      final emulatorHost = defaultTargetPlatform == TargetPlatform.android
          ? "10.0.2.2"
          : "localhost";
      FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
      FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
      FirebaseFunctions.instanceFor(region: "europe-west6")
          .useFunctionsEmulator('localhost', 5001);
      FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  configureDependencies();

  // url routing
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      scaffoldMessengerKey: globalSnackBarMessengerKey,
      title: appName,
      theme: theme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates +
          [const LocaleNamesLocalizationsDelegate()],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
