import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Go to initial location of the destination when it's already selected.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
              label: loc.profile_title, icon: const Icon(Icons.person)),
          NavigationDestination(
              label: loc.chat_title, icon: const Icon(Icons.chat)),
        ],
        onDestinationSelected: _goBranch,
      ),
      // alternative bottom bar:
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: loc.profile_title, icon: const Icon(Icons.person)),
          BottomNavigationBarItem(
              label: loc.chat_title, icon: const Icon(Icons.chat)),
        ],
        onTap: _goBranch,
      ),*/
    );
  }
}
