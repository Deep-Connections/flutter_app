import 'package:deep_connections/config/injectable.dart';
import 'package:deep_connections/models/user.dart';
import 'package:deep_connections/screens/auth/login_screen.dart';
import 'package:deep_connections/screens/home/home.dart';
import 'package:deep_connections/utils/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DcUser?>(context);

    if (user == null) {
      return LoginScreen(auth: getIt());
    } else {
      return Home(
          navigateCallback: () =>
              context.navigate(Home(navigateCallback: () {})));
      //NameProfileScreen(profileService: getIt());
      // ChatListScreen(chatService: getIt());
    }
  }
}
