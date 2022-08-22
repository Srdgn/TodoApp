import 'package:flutter/material.dart';
import 'package:todoapp/service/database.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task.dart';
import "package:todoapp/home/navigationDrawer.dart";
import 'package:todoapp/projectsPage/projectList.dart';
import 'package:todoapp/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:uuid/uuid.dart';
import 'package:todoapp/service/auth.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
   Widget build(BuildContext context) {
    return StreamProvider<List<Project>>.value(
      initialData: [],
      value: DatabaseService().projects,
      child: Scaffold(
          endDrawer: NavigationDrawerWidget(),
          appBar: AppBar(
          title: Text(
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30) ,
            'Projects'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
          body: ProjectList(),
          floatingActionButtonLocation: 
            FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              print("bass");
              String id = Uuid().v1();
              final User? user = auth.currentUser;
              final uid = user!.uid;
              final CollectionReference tasksCollection = FirebaseFirestore.instance.collection("projects").doc(id).collection("tasks");
              List<String> user_ids = [];
              List<String> admin_ids = [];
              user_ids.add(uid);
              admin_ids.add(uid);
              print(user_ids[0]); 

              Project project = Project(id: id,title: "Title" ,text: "Text",user_ids: user_ids,tasks: tasksCollection ,admin_ids: admin_ids);
              DatabaseService(uid: uid).updateProjectData( id, "Title" , "Text", user_ids,tasksCollection ,admin_ids);
            },
            child: Icon(Icons.add),
            ),
        ),
        
        
    );
  }
}
