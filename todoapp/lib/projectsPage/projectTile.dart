import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:todoapp/models/project.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:todoapp/projectsPage/projectTaskPage.dart';
import 'editProject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
class ProjectTile extends StatefulWidget {
  Project project;
  ProjectTile({required this.project});
  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  void _showEditPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return EditProject(project: widget.project);
      });
    }
  @override
  Widget build(BuildContext context) {
    String id = widget.project.id;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    bool isAdmin = widget.project.admin_ids.contains(uid);
    // var list= FirebaseFirestore.instance.collection("projects").where( "id/user_ids",arrayContains: uid.toString()).get();    //final document = FirebaseFirestore.instance.collection("projects").doc(id);
    //Project project = widget.project;
    //List<String> user_ids = projectCollection.doc(project.id).child() get();
    //List<String> names = List.from(document as Iterable<dynamic>);
    if(true){//widget.project.admin_ids.contains(uid)){
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
            title: Text(widget.project.user_ids.toString()),
            subtitle: Text(widget.project.text),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditPanel(),  
            ),
            ),
          ),
        ), 
      );
    }
   else return SizedBox(height: 0,width: 0,);
  }
}