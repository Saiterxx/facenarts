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
          TextField(
            decoration: InputDecoration(hintText: "Email"),
            onChanged: (value) {
              setState(() {
                _email = value.trim(); //remove whitespace
              });
            },
          ),
          //2.)
          TextField(
            decoration: InputDecoration(hintText: "Password"),
            onChanged: (value) {
              setState(() {
                _password = value.trim(); //remove whitespace
              });
            },
          ),

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
                          print("Login Success");
                          Navigator.of(context).pushNamed("/logged");
                        }
                        else{
                          print("Login Error");
                        }

                      } on FirebaseAuthException catch (e) {
                        print(e);
                      }
                    }),

          //4.)
          // ignore: deprecated_member_use
          RaisedButton(
              child: Text("Sign-Up"),
              onPressed: () {
                try {
                  auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                } catch (e) {
                  print("Error on signup " + e.toString());
                }
              })

        ],
      ),
    );
  }
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Auth"),
        ),
        body: myFirebaseForm());
  }



}
