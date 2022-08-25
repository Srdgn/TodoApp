import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:todoapp/home/navigationDrawer.dart";
import 'package:provider/provider.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/service/database.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/profilePage/profileProjectList.dart';

class ProfilePage extends StatefulWidget{
  User2 user;
  ProfilePage({required this.user});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override

     
  Widget build(BuildContext context) {
  //DocumentSnapshot userSnapshot = FirebaseFirestore.instance.collection('users').doc(widget.user_id).get();
    return StreamProvider<List<Project>>.value(
      initialData: [],
      value: DatabaseService().projects,
      child: Scaffold(
          endDrawer: NavigationDrawerWidget(),
          appBar: AppBar(
          title: Text(
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30) ,
            'Profile'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          
        ),
          body: ProfileProjectList(user: widget.user),
        ),  
    );
  }
}

