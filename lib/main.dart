import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'LoggedInPage.dart';
import 'LoginPage.dart';
import 'SettingsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/logged': (context) => LoggedInPage(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
