import 'package:flutter/material.dart';
import 'package:todoapp/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/service/database.dart';
import 'package:todoapp/models/project.dart';

class EditProject extends StatefulWidget {
  Project project;
  EditProject({required this.project});
  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
    String text = project.text;
    String title = project.title;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    Future<void> _showDelete(){  
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('This Task Will Be Deleted',style: TextStyle(fontWeight: FontWeight.bold),),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                      color: Colors.red,
                      onPressed: ()async{
                        Navigator.pop(context);
                        Navigator.pop(context);
                        
                        await DatabaseService(uid: user.uid).deleteProjectData(project.id);
                      },
                      icon: Icon(Icons.delete,color: Colors.white,),
                      label: Text("Delete",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 10,),
                  RaisedButton.icon(
                  color: Colors.blueGrey,
                  onPressed: (){Navigator.pop(context);},
                  icon:  Icon(Icons.cancel,color: Colors.white,),
                  label:  Text("Cancel",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    
    return Form(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children:<Widget> [
            SizedBox(height: 20,),
            Text(
              "Edit",
              style: TextStyle(fontSize: 26,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20,),
            TextFormField(
              initialValue: title,
              decoration: InputDecoration(
                prefixIcon: Padding(padding: EdgeInsets.symmetric(horizontal:15, vertical: 8), child: Text(
                  "Title: ",
                  style: TextStyle(fontSize:18 ,fontWeight: FontWeight.bold),
                ),),
                hintText: "Title",
                contentPadding: EdgeInsets.symmetric(horizontal:15, vertical: 8),
                ),
                onChanged: (title) => DatabaseService(uid: user.uid).updateProjectData( project.id, title, project.text, project.user_ids,/*CollectionReference tasks,*/  project.admin_ids)

            ),
            SizedBox(height: 20,),
            TextFormField(
              initialValue: text,
              decoration: InputDecoration(
                prefixIcon: Padding(padding: EdgeInsets.symmetric(horizontal:15, vertical: 8), child: Text(
                  "Text: ",
                  style: TextStyle(fontSize:18 ,fontWeight: FontWeight.bold),
                ),),
                
                hintText: "Text",
                contentPadding: EdgeInsets.symmetric(horizontal:15, vertical: 8),
                ),
                onChanged: (text) => DatabaseService(uid: user.uid).updateProjectData( project.id, project.title, text, project.user_ids,/*CollectionReference tasks,*/  project.admin_ids)

            ),
            SizedBox(height: 40,),
            RaisedButton.icon(
              color: Colors.red,
              onPressed: (){
                _showDelete();
              },
              icon: Icon(Icons.delete,color: Colors.white,),
              label: Text("Delete",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10,),
            /* RaisedButton.icon(        //Cancel button
              color: Colors.blueGrey,
              onPressed: (){
                print("cancel");
                print(initialTitle);
                DatabaseService(uid: user.uid).updateTaskData(widget.task.id,initialTitle,initialText, widget.task.uid,widget.task.checked );
                Navigator.pop(context);},
              icon: Icon(Icons.cancel,color: Colors.white,),
              label: Text("Cancel",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              ), */
            SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}