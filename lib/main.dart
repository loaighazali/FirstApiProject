import 'package:elancer_api/pref/shared_pref_controller.dart';
import 'package:elancer_api/screens/auth/login_screen.dart';
import 'package:elancer_api/screens/auth/register_screen.dart';
import 'package:elancer_api/screens/categories_screen.dart';
import 'package:elancer_api/screens/lunch_screen.dart';
import 'package:elancer_api/screens/users_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/lunch_screen',
      routes: {
        '/lunch_screen' : (context) =>const LunchScreen(),
        '/login_screen' : (context) =>const LoginScreen(),
        '/register_screen' : (context) =>const RegisterScreen(),
        '/users_screen' : (context) =>const UsersScreen(),
        '/categories_screen' : (context) =>const CategoriesScreen(),
      },

    );
  }
}
