import 'package:flutter/material.dart';
import 'package:todoapp/service/auth.dart';
import "package:firebase_auth/firebase_auth.dart";



class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/logo.png")),
              FlatButton.icon(
                icon: Icon(Icons.logout),
                label:Text("logout"),
                onPressed: ()async{
                  await FirebaseAuth.instance.signOut();
                })
            ],
          )
          ) 
        );
  }
}



