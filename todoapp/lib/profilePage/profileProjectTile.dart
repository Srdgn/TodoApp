import 'package:todoapp/models/project.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:todoapp/projectsPage/projectTaskPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/models/user2.dart';

class ProfileProjectTile extends StatefulWidget {
  Project project;
  User2 projectUser;
  ProfileProjectTile({required this.project, required this.projectUser});
  
  @override
  State<ProfileProjectTile> createState() => _ProfileProjectTileState();
}

class _ProfileProjectTileState extends State<ProfileProjectTile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<dynamic> uid_list = [];
  List<dynamic> admin_list = [];
  late bool visible;

  
  
  @override
  Widget build(BuildContext context) {

    final User? user = auth.currentUser;
    final uid = user!.uid;
    
    FirebaseFirestore.instance.collection('projects').doc(widget.project.id).get().then((DocumentSnapshot documentSnapshot) {
      setState(() { uid_list= List.from(documentSnapshot["user_ids"]); });
      setState(() { admin_list= List.from(documentSnapshot["admin_ids"]); });
      setState(() { visible=documentSnapshot["visible"]; });

    });
    if(uid_list.contains(widget.projectUser.id) && visible){
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child:
        GestureDetector(
          onTap: () => {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ProjectTaskPage(project: widget.project)),
                  )},
          child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            title: Text(widget.project.title),
            subtitle: Text(widget.project.text),
            ),
          ),
        ), 
      );
    } 
    else return SizedBox(height: 0,width: 0,);
  }
  
}