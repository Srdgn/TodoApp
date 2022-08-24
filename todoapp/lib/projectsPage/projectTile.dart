import 'package:todoapp/models/project.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:todoapp/projectsPage/projectTaskPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editProject.dart';

class ProjectTile extends StatefulWidget {
  Project project;
  ProjectTile({required this.project});
  
  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<dynamic> uid_list = [];
  List<dynamic> admin_list = [];
  void _showEditPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return EditProject(project: widget.project);
      });
    }
  
  
  @override
  Widget build(BuildContext context) {

    final User? user = auth.currentUser;
    final uid = user!.uid;
    
    FirebaseFirestore.instance.collection('projects').doc(widget.project.id).get().then((DocumentSnapshot documentSnapshot) {
      setState(() { uid_list= List.from(documentSnapshot["user_ids"]); });
      setState(() { admin_list= List.from(documentSnapshot["admin_ids"]); });

    });
    if(uid_list.contains(uid.toString())){
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
            trailing: (admin_list.contains(uid))
              ?IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _showEditPanel(),)
              : null,
            ),
          ),
        ), 
      );
    } 
    else return SizedBox(height: 0,width: 0,);
  }
  
}