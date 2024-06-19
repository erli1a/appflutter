
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/dresses_screen.dart';
import 'package:proyecto/firebase_options.dart';
import 'package:proyecto/login_screen.dart';
import 'package:proyecto/profile_screen.dart';
import 'welcome_screen.dart';

import 'register_screen.dart';
import 'project_description_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => WelcomeScreen(), 
        '/login': (context) => LoginScreen(), 
        '/register': (context) => RegisterScreen(), 
        '/projectDescription': (context) => ProjectDescriptionScreen(), 
        '/dresses': (context) => DressesScreen(cart: []), 
        '/profile': (context) => ProfileScreen()
        
      },
    );
  }
}
