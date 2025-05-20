import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    required this.navigationShell,
    required this.folders,
  });

  static const path = '/dashboard';

  final StatefulNavigationShell navigationShell;
  final List<String> folders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            destinations: [
              const NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Главная'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.folder),
                label: Text('Папки (${folders.length})'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.schedule),
                label: Text('Расписание'),
              ),
            ],
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
