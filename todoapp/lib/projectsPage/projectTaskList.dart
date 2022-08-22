import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:todoapp/models/task.dart';

import 'projectTaskTile.dart';

class ProjectTaskList extends StatefulWidget {


  @override
  State<ProjectTaskList> createState() => _ProjectTaskListState();
}

class _ProjectTaskListState extends State<ProjectTaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context , index){

          return ProjectTaskTile(task: tasks[index]);

        },
        ),
    );
  }
}