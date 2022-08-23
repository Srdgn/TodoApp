import 'package:flutter/material.dart';
import 'package:todoapp/home/taskList.dart';
import 'package:todoapp/service/database.dart';
import 'package:provider/provider.dart';
import "package:todoapp/home/navigationDrawer.dart";
import 'package:todoapp/projectsPage/projectList.dart';
import 'package:todoapp/models/project.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/service/auth.dart';
import 'package:todoapp/projectsPage/projectTaskList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:todoapp/models/task.dart';
import 'package:todoapp/home/editTask.dart';
import 'package:uuid/uuid.dart';


class ProjectTaskPage extends StatefulWidget {
  final Project project;
  ProjectTaskPage({required this.project});

  @override
  State<ProjectTaskPage> createState() => _ProjectTaskPageState();
}

class _ProjectTaskPageState extends State<ProjectTaskPage> {

  List<Task> _projectTaskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
        id: doc.id,
        project_id: widget.project.id,
        title: doc.get("title") ?? "",
        text: doc.get("text") ?? "",
        uid: doc.get("uid") ?? "",
        checked: doc.get("checked") ?? "",
        );
    }).toList();
  }
  Stream<List<Task>> projectTasks(Stream<QuerySnapshot> tasksStream){
    return tasksStream.map(_projectTaskListFromSnapshot);
  }

  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  
  
  @override
   Widget build(BuildContext context) {
    CollectionReference tasks = FirebaseFirestore.instance.collection("projects").doc(widget.project.id).collection("tasks");
    final Stream<List<Task>> tasksStream = projectTasks(tasks.snapshots());
    return StreamProvider<List<Task>>.value(
      initialData: [],
      value: tasksStream,
      child: Scaffold(
          endDrawer: NavigationDrawerWidget(),
          appBar: AppBar(
          title: Text(
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30) ,
            'Tasks'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
        
        body: ProjectTaskList(),
        floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              var id = Uuid();
              final User? user = auth.currentUser;
              final uid = user!.uid;
              Task task = Task(id: id.v1(),project_id: widget.project.id,title: "",text: "" ,uid: user.uid,checked: false);
              await showModalBottomSheet(context: context,builder: (context){
                return EditTask(task: task,projectTask: true,);
              });              
            },
            child: Icon(Icons.add),
            ),
            
        ),
        
        
    );
  }
}
