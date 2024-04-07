import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:flutter/material.dart';

class ProfileNavScreen extends StatelessWidget {
  final ProfileNavigationStep navigationStep;
  final Function()? navigatePrevious;
  final Widget body;

  const ProfileNavScreen(
      {super.key,
      required this.navigationStep,
      this.navigatePrevious,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(onBack: navigatePrevious, body: body);
  }
}
