import 'package:todoapp/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Project{
  final String id; 
  final String title;
  final String text;
  List<String> user_ids = <String>[] ;
  //final CollectionReference tasks;
  List<String> admin_ids = <String>[];
  final bool visible ;
  Project({required this.id,required this.title,required this.text,required user_ids,/*required  this.tasks,*/ required admin_ids, required this.visible});

}