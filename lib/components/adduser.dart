import 'dart:math';
//import 'package:authen_ui/components/signin.dart';
//import 'package:authen_ui/components/tran.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adduser extends StatefulWidget {
  final String status;
  const Adduser({Key key, this.status}) : super(key: key);

  @override
  _creteuserState createState() => _creteuserState();
}

class _creteuserState extends State<Adduser> {
  String status;
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/2.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                textfield1("E-mail", 'email', false),
                Text(""),
                textfield1("Password", 'password', true),
                Text(""),
                textfield1("Confirm-Password", 'password', true),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButtoncreteuser(),
              //buildButtonSignOut(),
              buildButtonBack(),
            ],
          )
        ],
      ),
    );
  }

  Container buildButtoncreteuser() {
    return Container(
        constraints: BoxConstraints.expand(width: 200, height: 40),
        child: InkWell(
          child: Text("Create User",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white)),
          onTap: () async {
            await createUser();
            // Navigator.pushReplacement(
            //    context, MaterialPageRoute(builder: (context) => tran()));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#F48A55"), HexColor("#F24C2F")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
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

  void changes(String test, String mode) {
    if (mode == 'email')
      email = test;
    else if (mode == 'password') password = test;
  }

  Widget textfield1(String text, String func, bool obscure) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      onChanged: (word) => changes(word, '$func'),
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("#41C66A"), width: 2.5),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("#41C66A"), width: 2.5),
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: '$text',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Container buildButtonBack() {
    return Container(
        constraints: BoxConstraints.expand(width: 200, height: 40),
        child: InkWell(
          child: Text("Back",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white)),
          onTap: () {
            back();
           // Navigator.pushReplacement(
                //context, MaterialPageRoute(builder: (context) => Signin()));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#F8D662"), HexColor("#F76923")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  void back() {
    //Navigator.pushReplacement(
      //  context, MaterialPageRoute(builder: (context) => tran()));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
