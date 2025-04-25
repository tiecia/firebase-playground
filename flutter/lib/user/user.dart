import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:firebase_playground/dataconnect-generated/dart/default_connector/default.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserListFetcher();
  }
}

class UserListFetcher extends StatelessWidget {
  const UserListFetcher({super.key});

  @override
  Widget build(BuildContext context) {
    Future<QueryResult<GetUsersData, void>> userFuture =
        DefaultConnector.instance.getUsers().execute();
    return FutureBuilder<QueryResult<GetUsersData, void>>(
      future: userFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<QueryResult<GetUsersData, void>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var users = snapshot.data!.data.users;
          return UserList(users: users);
        } else {
          return Text("Failed to load users");
        }
      },
    );
  }
}

class UserList extends StatelessWidget {
  final List<GetUsersUsers> users;

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int idx) {
            var user = users[idx];
            return Material(
              child: ListTile(
                title: Text(user.displayName),
                subtitle: Text(user.email ?? ""),
                leading: Icon(Icons.person),
                onTap:
                    () => context.go(
                      Uri(
                        path: '/users',
                        queryParameters: {'id': user.userId},
                      ).toString(),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final String userId;
  const UserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
