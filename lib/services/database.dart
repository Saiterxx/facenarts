import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String _email;
  DatabaseService(this._email);

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  
  Future updateUserData(String username) async{
    return await userCollection.doc(_email).set({
      'Username': username
    });
  }

}