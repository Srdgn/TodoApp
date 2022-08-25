import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:todoapp/home/navigationDrawer.dart";
import 'package:provider/provider.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/service/database.dart';
import 'package:todoapp/projectsPage/projectList.dart';

class ProfilePage extends StatefulWidget{
  String user_id;
  ProfilePage({required this.user_id});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late String user_name;
  late List<dynamic> project_list;
  @override

     
    
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('users').doc(widget.user_id).get().then((DocumentSnapshot documentSnapshot) {
      setState(() { user_name = documentSnapshot["name"]; });
      setState(() { project_list= List.from(documentSnapshot["project_ids"]); });
    });
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
          body:  Column(
            children: [
              ProjectList(),
              Center(
                child: Icon(Icons.person_rounded, size: 40,),
                /*
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/thicc.jpg"),             // IMAGE
                  radius: 100,
                ),*/
    
              ),
              Divider(
                height: 40,
                
              ),
              Text(
                "Name: "+user_name,
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Projects",
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
        ),
        
        
    );
            /*Scaffold(
        backgroundColor: Colors.lightGreenAccent[500],
        endDrawer: NavigationDrawerWidget(),
            appBar: AppBar(
            title: Text(
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30) ,
              "Profile"),
            backgroundColor: Colors.blueAccent,
            elevation: 0.0,
          ),
    
    
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.person_rounded, size: 40,),
                /*
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/thicc.jpg"),             // IMAGE
                  radius: 100,
                ),*/
    
              ),
              Divider(
                height: 40,
                
              ),
              Text(
                "Name: "+user_name,
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Projects",
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
             
                    
            ]),
            
          ),
      ),*/
  }
}

