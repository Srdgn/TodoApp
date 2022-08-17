import 'package:flutter/material.dart';
import 'package:todoapp/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskTile extends StatelessWidget {
  
  final Task task;
  TaskTile({required this.task});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: ButtonWithIcon(),
          title: Text(task.title),
          subtitle: Text(task.text),
        ),
        ),
      );
  }
}

class ButtonWithIcon extends StatefulWidget {
  const ButtonWithIcon({Key? key}) : super(key: key);

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  bool checked = false;
  Widget build(BuildContext context) {
    return IconButton(
            icon: checked 
                ? Icon(Icons.check_box_outlined)
                : Icon(Icons.check_box_outline_blank),
            onPressed: () {
              setState((){
                checked = !checked;
              });
            },
          );
  }
}

