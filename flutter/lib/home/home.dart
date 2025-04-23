import 'package:firebase_playground/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(bottomNavigationBar: NavBar(), body: Placeholder(),);
  }
}
