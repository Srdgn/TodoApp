import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/projectsPage/projectTile.dart';
import 'package:todoapp/models/project.dart';
import 'profileProjectTile.dart';
import 'package:todoapp/models/user2.dart';

class ProfileProjectList extends StatefulWidget {
  User2 user;
  ProfileProjectList({required this.user});
  @override
  _ProfileProjectListState createState() => _ProfileProjectListState();
}

class _ProfileProjectListState extends State<ProfileProjectList> {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>>(context);
          
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      
      child: 
          Column(
            children: [
              Center(
                child: Icon(Icons.person_rounded, size: 40,),
              ),
              Divider(
                height: 40,
              ),
              Text(
                "Name: "+ widget.user.name,
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
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    
                    itemCount: projects.length,
                    itemBuilder: (context , index){
                      
                      return ProfileProjectTile(project: projects[index], projectUser: widget.user);
                      
                    },
                    ),
                ),
              ),
            ],
          ),
      );
  }
}