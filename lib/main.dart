import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/firebase_options.dart';
import 'package:deep_connections/navigation/main_navigation.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/constants.dart';
import 'config/injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      scaffoldMessengerKey: globalSnackBarMessengerKey,
      title: APP_NAME,
      theme: theme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
