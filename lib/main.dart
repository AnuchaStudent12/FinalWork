import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manager_app/components/adduser.dart';
import 'package:manager_app/components/index.dart';
import 'package:manager_app/components/signin.dart';
import 'package:manager_app/components/adduser.dart';

import 'components/register.dart';
import 'components/testing.dart';


void main() async {
  //runApp(MyApp());
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print("User is currently signed out!");
    } else {
      print("User is signed In !");
    }
  });
  await auth.signOut();

  runApp(MaterialApp(
    home: Scaffold(
    //body: Adduser(),
    //body: Index(),
    body: Signin(),
    //body: Register(),

    ),
   builder: EasyLoading.init(),
  ));
}
