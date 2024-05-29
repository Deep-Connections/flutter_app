import 'package:deep_connections/config/constants.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: theme.bottomAppBarTheme.color,
        indicatorColor: theme.colorScheme.tertiary,
        height: theme.bottomAppBarTheme.height,
        destinations: [
          ...routes.map(
            (route) => NavigationDestination(
              label: route.title.localize(loc),
              icon: Icon(
                route.icon,
                color: theme.colorScheme.onTertiary,
                size: bottomBarIconSize,
              ),
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
        items: routes.map(
          (route) => BottomNavigationBarItem(
            label: route.title.localize(loc),
            icon: Icon(
              route.icon,
              size: 32, // default 24
            ),
          ),
        ).toList(),
        onTap: _goBranch,
      ),*/
    );
  }
}
