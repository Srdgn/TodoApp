import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:todoapp/models/task.dart';
import 'package:todoapp/home/taskTile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskList extends StatefulWidget {

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context , index){

          return TaskTile(task: tasks[index]);

        },
        ),
    );
  }
}