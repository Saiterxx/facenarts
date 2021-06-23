import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String _email;
  DatabaseService(this._email);

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  
  Future updateUserData(String username, String email) async{
    return await userCollection.doc(_email).set({
      'Username': username,
      'Email': email
    });
  }

  Future getByUsername(String username) async{
    return userCollection.doc(username).get().then((DocumentSnapshot documentSnapshot){
      return ('Deu certo! o que está armazenado é:  + ${documentSnapshot.data()}');
    }
    );
  }

}