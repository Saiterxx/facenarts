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
            FirebaseFirestore.instance.collection("users").where('Email', isEqualTo: email).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("Carregando Documentos...");
          return new ListView(padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),children: getListItems(snapshot));
        }));
  
}

getListItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map<Widget>((doc) =>  Card(
            child: ListTile(

            leading: CircleAvatar(radius: 25),
            title: new Text('Nome de usuário: \n'+ doc["Username"]),)),)
      .toList();
}



}