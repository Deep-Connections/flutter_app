import 'package:deep_connections/navigation/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<BottomNavRoute> routes;

  const BottomNavBar({
    Key? key,
    required this.navigationShell,
    required this.routes,
  }) : super(key: key);

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
          ...routes.map(
            (route) => NavigationDestination(
              label: route.title.localize(loc),
              icon: Icon(route.icon),
            ),
          ),
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
