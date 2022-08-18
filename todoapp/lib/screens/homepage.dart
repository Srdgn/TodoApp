import 'package:flutter/material.dart';
import 'package:todoapp/home/taskList.dart';
import 'package:todoapp/service/auth.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/service/database.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task.dart';
import 'package:uuid/uuid.dart';
import "package:todoapp/home/navigationDrawer.dart";
import 'package:todoapp/home/editTask.dart';
import "package:cloud_firestore/cloud_firestore.dart";
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
              var id = Uuid();
              final User? user = auth.currentUser;
              final uid = user!.uid;
              //task = tasks.where((element) => element.id == uuid).first;
              Task task = Task(id: id.v1(),title: "",text: "" ,uid: user.uid,checked: false);
              await showModalBottomSheet(context: context,builder: (context){
                return EditTask(task: task);
              });              
            },
            child: Icon(Icons.add),


            ),
          ),
    );
  }
}



