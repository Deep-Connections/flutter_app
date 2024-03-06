import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/firebase_options.dart';
import 'package:deep_connections/screens/wrapper.dart';
import 'package:deep_connections/services/auth.dart';
import 'package:deep_connections/services/error_handling.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().userStream,
      child: MaterialApp(
        scaffoldMessengerKey: globalSnackBarMessengerKey,
        title: APP_NAME,
        theme: theme(),
        home: const Wrapper(),
      ),
    );
  }
}
