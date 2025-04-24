import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_playground/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_playground/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> firebaseInitFuture = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return SafeArea(
      child: FutureBuilder(
        future: firebaseInitFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Error connecting to Firebase",
              textDirection: TextDirection.ltr,
            );
          } else {
            return MaterialApp.router(routerConfig: router);
          }
        },
      ),
    );
  }
}
