import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/projectsPage/projectTile.dart';
import 'package:todoapp/models/project.dart';

class ProjectList extends StatefulWidget {

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>>(context);
          
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context , index){
          
          return ProjectTile(project: projects[index]);
          
        },
        ),
    );
  }
}