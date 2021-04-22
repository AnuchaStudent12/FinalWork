import 'dart:math';

import 'package:manager_app/components/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Register extends StatefulWidget {
  final String status;
  const Register({Key key, this.status}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Register>{

  String status;
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

 TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final emailField = TextField(
      onChanged: (String string){email = string.trim();},
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      onChanged: (String string){password = string.trim();},
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final confirmpasswordField = TextField(
      onChanged: (String string){password = string.trim();},
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm-Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (
        ) {
          createUser();
          Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Index()));
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );




    final backButton = Material(


      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffdc5335),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (
        ) {
          back();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Index()));
        },
        child: Text("Back",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.blue[100],
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 25.0),
                confirmpasswordField,
                SizedBox(height: 35.0,),
                registerButton,
                SizedBox(height: 15.0,),
                backButton,
                SizedBox(height: 15.0,),
                SizedBox(height: 250.0,),
              ],
            ),
          ),
        ),
      ),
        )
    );

    
  }

   void back() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Index()));
  }

   Future createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "$email", password: "$password");
      EasyLoading.showSuccess("Created");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The Password is to weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

}
