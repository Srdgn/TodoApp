import 'package:flutter/material.dart';
import 'package:todoapp/home/taskList.dart';
import 'package:todoapp/service/auth.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/service/database.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task.dart';
import 'package:uuid/uuid.dart';
import "package:todoapp/home/navigationDrawer.dart";

class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      initialData: [],
      value: DatabaseService().tasks,
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
          body: TaskList(),
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              var uuid = Uuid();
              final User? user = auth.currentUser;
              final uid = user!.uid;
              await DatabaseService(uid: user.uid).updateTaskData(uuid.v1(),"Title","Text", user.uid, false);
            },
            child: Icon(Icons.add),


            ),
          ),
    );
  }
}



