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
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: FutureBuilder<QueryResult<GetUsersData, void>>(
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
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<GetUsersUsers> users;

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  () => context.push(
                    Uri(
                      path: '/users',
                      queryParameters: {'id': user.userId},
                    ).toString(),
                  ),
            ),
          );
        },
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final String userId;
  const UserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return UserFetcher(userId: userId);
  }
}

class UserFetcher extends StatelessWidget {
  final String userId;
  const UserFetcher({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    var userFuture =
        DefaultConnector.instance.getUser(userId: userId).execute();
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var user = snapshot.data!.data.user;
            if (user != null) {
              return UserDetails(user: user);
            } else {
              return UserNotFoundPage();
            }
          } else {
            return Text("Failed to load users");
          }
        },
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  final GetUserUser user;
  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.account_circle, size: 100),
          Column(
            children: [
              Text(user.displayName, style: theme.textTheme.headlineMedium),
              Text(
                user.email ?? "No email provided",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserNotFoundPage extends StatelessWidget {
  const UserNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("User was not found"));
  }
}
