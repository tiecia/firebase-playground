import 'package:firebase_playground/home/home.dart';
import 'package:firebase_playground/shell.dart';
import 'package:firebase_playground/user/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

var appRoutes = {
  '/': (context) => HomePage(),
  '/users': (context) => UserListPage(),
};

final GoRouter router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return NavBarShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/users',
              builder: (context, state) {
                var id = state.uri.queryParameters['id'];
                if (id == null) {
                  return UserListPage();
                } else {
                  return UserPage(userId: id);
                }
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
