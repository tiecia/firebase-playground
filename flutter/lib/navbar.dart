import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final StatefulNavigationShell navigationShell;
  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Users'),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (int idx) {
        // switch (idx) {
        //   case 0:
        //     Navigator.pushNamed(context, "/");
        //     break;
        //   case 1:
        //     Navigator.pushNamed(context, "/users");
        //     break;
        //   default:
        // }
        navigationShell.goBranch(idx);
      },
    );
  }
}
