import 'package:firebase_playground/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavBar(
        selectedIndex: navigationShell.currentIndex,
        navigationShell: navigationShell,
      ),
    );
  }
}
