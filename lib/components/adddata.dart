import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manager_app/components/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Adddata extends StatefulWidget {
  final String status;
  const Adddata({Key key, this.status}) : super(key: key);

  @override
  _AdddataState createState() => _AdddataState();
}

class _AdddataState extends State<Adddata>{
  String iddoc;
  String name;
  String age;
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

    final nameField = TextField(
      onChanged: (String string){name = string.trim();},
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final ageField = TextField(
      onChanged: (String string){age = string.trim();},
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Age",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final addButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (
        ) {
          addDataUser();
          Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Index()));
        },
        child: Text("Save",
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
                nameField,
                SizedBox(height: 25.0),
                ageField,
                SizedBox(height: 25.0),
                addButton,
                SizedBox(height: 35.0,),
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

void addDataUser() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('test');
    EasyLoading.showSuccess("Created");
    users
        .add({'name': '$name', 'age': '$age'})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

}
