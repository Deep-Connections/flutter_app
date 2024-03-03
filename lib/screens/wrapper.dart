import 'package:deep_connections/models/User.dart';
import 'package:deep_connections/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_switch.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DcUser?>(context);

    if (user == null) {
      return const AuthSwitch();
    } else {
      return Home();
    }
  }
}
