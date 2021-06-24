import 'package:facenarts/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _newusername;
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
const Card(
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Hello World!'),
  ),
);
    Widget myFirebaseForm() {
    return Center(
      
        child: Column( 
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //1.)
          Card(
           child: ListTile(

          title: new Text('Insira seu novo nome de usuário', textAlign: TextAlign.center,), )
          ),
          Card(
            child: 

           TextField(
            decoration: InputDecoration(
            icon: Icon(Icons.person),hintText: ""),
            onChanged: (value) {
              setState(() {
                _newusername = value.trim(); //remove whitespace
              });
            },
          ),
          // ignore: deprecated_member_use
          ),RaisedButton(
                    child: Text("Atualizar"),
                    onPressed: () async {
                      try {
                        // ignore: unnecessary_null_comparison
                        if(auth!=null){
                          print('pog');

                          addName(_newusername, auth.currentUser!.email.toString());
                           
                          Navigator.of(context).pushNamed("/logged");
                          ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(
                        'Nome de Usuário atualizado com sucesso.'
                      )));
                        }
                        else{
                          print("Erro no Login ");
                        }

                      } on FirebaseAuthException catch (e) {
                        print(e);
                      }
                    }),

          //4.)
          // ignore: deprecated_member_use
        ],
        
      ),
      
    );
    
  }
    return Scaffold(
        appBar: AppBar(
        title: Text("FacenArts"),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
              print("User BEFORE Log-Out -> " + auth.currentUser!.email.toString());
              await auth.signOut();
              print("User AFTER Log-Out -> " + auth.currentUser.toString());
              Navigator.of(context).pushNamed("/");
            }
            ,
        )]),
        body: myFirebaseForm());
  }

  Future addName(String _newusername, String email) async{
    await DatabaseService(email).updateUserData(_newusername, email);
  }



}
