import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:provider/provider.dart";
import 'package:todoapp/models/task.dart';
import 'package:todoapp/home/taskTile.dart';

class TaskList extends StatefulWidget {

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context , index){
        return TaskTile(task: tasks[index]);
      },
      );
  }
}