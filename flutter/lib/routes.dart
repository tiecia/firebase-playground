import 'package:firebase_playground/home/home.dart';
import 'package:firebase_playground/user/user.dart';

var appRoutes = {
  '/': (context) => HomePage(),
  '/users': (context) => UserPage(),
};
