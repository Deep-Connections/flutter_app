import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/firebase_options.dart';
import 'package:deep_connections/navigation/graphs/main_nav_graph.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:firebase_core/firebase_core.dart';
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

  configureDependencies(getEnvironment());

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
