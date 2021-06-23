import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:facenarts/services/database.dart';

class LoggedInPage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("FacenArts"),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () async {
              Navigator.of(context).pushNamed("/settings");
            }
            ,
        ),
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
              print("User BEFORE Log-Out -> " + auth.currentUser!.email.toString());
              await auth.signOut();
              print("User AFTER Log-Out -> " + auth.currentUser.toString());
              Navigator.of(context).pushNamed("/");
            }
            ,
        )]),
        
        body: Center(
        
        child: myList()
  ),
  );
    
  }

  Widget myList() {
    String? email = auth.currentUser!.email.toString();
  return (
     StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("users").where('Email', isEqualTo: email).limit(1).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("No documents");
          return new ListView(children: getListItems(snapshot));
        }));
  
}

getListItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => new ListTile(
            leading: CircleAvatar(radius: 25),
            title: new Text(doc["Username"]),
          ))
      .toList();
}



}