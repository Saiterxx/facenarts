import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoggedInPage extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
            child: Text("Logout"),
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushNamed("/");
            }),
      ),
    );
  }
}
