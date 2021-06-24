import 'package:facenarts/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    Widget myFirebaseForm() {
    return Center( 
      child: Column( 
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //1.)
          Card(
          child: TextField(
            decoration: InputDecoration(icon: Icon(Icons.person),hintText: "Email"),
            onChanged: (value) {
              setState(() {
                _email = value.trim(); //remove whitespace
              });
            },
          ),),
          //2.)
          Card(
          child: TextField(
            obscureText: true,
            decoration: InputDecoration( icon: Icon(Icons.lock),hintText: "Password"),
            onChanged: (value) {
              setState(() {
                _password = value.trim(); //remove whitespace
              });
            },
          ),),

          //3.)
          // ignore: deprecated_member_use
          RaisedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      try {
                        var authUser = await auth.signInWithEmailAndPassword(
                            email: _email, password: _password);
                        // ignore: unnecessary_null_comparison
                        if(authUser!=null){
                          print(authUser);
                          print("Sucesso no Login");
                          Navigator.of(context).pushNamed("/logged");
                          ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(
                        'Bem vindo(a) de volta!'
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
          RaisedButton(
              child: Text("Registrar"),
              onPressed: () {
                try {
                  auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                      addName(_email);
                      ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(
                        'Registrado com sucesso!'
                      )));
                } catch (e) {
                  print("Erro ao se registrar " + e.toString());
                }
              })

        ],
      ),
    );
  }
    return Scaffold(
        appBar: AppBar(
          title: Text("FacenArts"),
        ),
        body: myFirebaseForm());
  }

  Future addName(String _email) async{
    await DatabaseService(_email).updateUserData(_email, _email);
  }



}
