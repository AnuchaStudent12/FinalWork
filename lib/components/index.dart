import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manager_app/components/adddata.dart';
import 'package:manager_app/components/signin.dart';

import 'item_page.dart';

class Index extends StatefulWidget {
  
  final String status;
  const Index({Key key, this.status}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Index>{


  final TextEditingController _textEditingController = TextEditingController();
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('test');
  String status;
//FirebaseAuth auth = FirebaseAuth.instance;
  String email;
  String password;


 TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
   return Scaffold(
      appBar: AppBar(
        title: const Text('Manager App'),
      ),
    body: StreamBuilder(stream: collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.hasData){
        return ListView(
          children: snapshot.data.docs.map((e) => Column(
            children: [
              ListTile(title: Text(e['name']),subtitle:Text(e['age']) ,),
              Divider(color: Colors.black.withOpacity(0.6), thickness: 2,)
            ],
          )).toList(),
        );
      }
      return Center(child: CircularProgressIndicator(),);
      },
    ),
   
   floatingActionButton: FloatingActionButton(
     child: Icon(Icons.add),
     onPressed: (
     ){

        Adddata();
        Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Adddata()));
     },
   ),
      drawer: Drawer(
      child: ListView(
      padding: EdgeInsets.zero,
      children:  <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
         // child: 
        child : Reademail(),  
                   /* Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),*/
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: (){
            onClickSignOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Signin()));
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
    ),   
      ),
    );
  }
    void back() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Index()));
  }
  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showInfo("Sign-Out Complete");
  }

}

class Reademail extends StatelessWidget {
  const Reademail({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snap) {
            final user = snap.data;
            if (user != null) {
              return Text('${user.email}',
                  style: TextStyle(color: Colors.white, fontSize: 22));
            }
            return Text('sign-out',
                style: TextStyle(color: Colors.black, fontSize: 22));
          },
        );
  }
}


class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.collectionReference,
  }) : super(key: key);

  final CollectionReference collectionReference;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.hasData){
        return ListView(
          children: snapshot.data.docs.map((e) => Column(
            children: [
              ListTile(title: Text(e['name']),subtitle:Text(e['age']) ,),
              Divider(color: Colors.black.withOpacity(0.6), thickness: 2,)
            ],
          )).toList(),
        );
      }
      return Center(child: CircularProgressIndicator(),);
      },
            );
  }
}

