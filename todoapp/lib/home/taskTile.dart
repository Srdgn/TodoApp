import 'package:flutter/material.dart';
import 'package:todoapp/home/editTask.dart';
import 'package:todoapp/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/service/database.dart';

class TaskTile extends StatefulWidget {
  Task task;
  TaskTile({required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    void _showEditPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return EditTask(task: widget.task);
      });
    }
    if(widget.task.uid == uid){
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: IconButton(
              icon: widget.task.checked 
                  ? Icon(Icons.check_box_outlined,color:Colors.green,)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: () async{
                await DatabaseService(uid: user.uid).updateTaskData(widget.task.id,widget.task.title, widget.task.text, widget.task.uid, !widget.task.checked );
              }
            ),
            title: Text(widget.task.title),
            subtitle: Text(widget.task.text),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditPanel(),
              ),
            ),
          ),
      );
    }
    else return SizedBox(height: 0,width: 0,);
  }
}
