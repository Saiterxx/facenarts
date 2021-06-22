import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoggedInPage extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("FacenArts"),
                  actions: [
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
              print("User BEFORE Log-Out -> " + auth.currentUser.toString());
              await auth.signOut();
              print("User AFTER Log-Out -> " + auth.currentUser.toString());

              Navigator.of(context).pushNamed("/");
            }
        )]),
    );
    
  }
  
}

