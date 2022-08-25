import 'package:flutter/material.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/service/database.dart';
import 'package:provider/provider.dart';
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
          
        ),
          body:  ProjectList(),
          floatingActionButtonLocation: 
            FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              String id = Uuid().v1();
              final User? user = auth.currentUser;
              final uid = user!.uid;
              final CollectionReference tasksCollection = FirebaseFirestore.instance.collection("projects").doc(id).collection("tasks");
              List<String> user_ids = [];
              List<String> admin_ids = [];
              user_ids.add(uid);
              admin_ids.add(uid);

              FirebaseFirestore.instance.collection('users').doc(uid).get().then((DocumentSnapshot documentSnapshot) {
                String name = documentSnapshot["name"];
                List<String> project_list= List.from(documentSnapshot["project_ids"]);
                project_list.add(id);
                DatabaseService(uid: user.uid).updateUserData( name , project_list);
              });              
              DatabaseService(uid: uid).updateProjectData( id, "Title" , "Text", user_ids,/*tasksCollection,*/ admin_ids, true);

            },
            child: Icon(Icons.add),
            ),
        ),
        
        
    );
  }
}



