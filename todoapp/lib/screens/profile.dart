import 'package:flutter/material.dart';
import 'package:todoapp/models/user2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:todoapp/home/navigationDrawer.dart";


class ProfilePage extends StatefulWidget{
  String user_id;
  ProfilePage({required this.user_id});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late String user_name;
  late List<String> project_list;
  @override
  Widget build(BuildContext context){
     
    FirebaseFirestore.instance.collection('users').doc(widget.user_id).get().then((DocumentSnapshot documentSnapshot) {
      setState(() { user_name = documentSnapshot["name"]; });
      setState(() { project_list= List.from(documentSnapshot["project_ids"]); });
    });
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[500],
      endDrawer: NavigationDrawerWidget(),
          appBar: AppBar(
          title: Text(
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30) ,
            "Profile"),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          
        ),


      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.person_rounded, size: 40,),
              /*
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/thicc.jpg"),             // IMAGE
                radius: 100,
              ),*/

            ),
            Divider(
              height: 40,
              
            ),
            Text(
              "Name: "+user_name,
              style: TextStyle(
                color: Colors.blueGrey,
                letterSpacing: 2,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Projects",
              style: TextStyle(
                color: Colors.blueGrey,
                letterSpacing: 2,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            
          ]),
          
        ),
    );
  }
}

