import 'package:todoapp/models/project.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class ProjectTile extends StatefulWidget {
  Project project;
  ProjectTile({required this.project});
  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    /* void _showEditPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return EditTask(task: widget.task);
      });
    } */
    //if(widget.task.uid == uid){
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            
            title: Text(widget.project.title),
            subtitle: Text(widget.project.text),
            ),
          ),
      );
    //} if
    //else return SizedBox(height: 0,width: 0,);
  }
}