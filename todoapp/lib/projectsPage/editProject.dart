import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/service/database.dart';
import 'package:todoapp/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProject extends StatefulWidget {
  Project project;
  EditProject({required this.project});
  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  List<dynamic> uid_list = [];    
  List<dynamic> admin_list = [];
  
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
    bool visible = project.visible;
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
                        FirebaseFirestore.instance.collection('users').doc(uid).get().then((DocumentSnapshot documentSnapshot) {
                          String name = documentSnapshot["name"];
                          List<String> project_list= List.from(documentSnapshot["project_ids"]);
                          project_list.remove(project.id);
                          DatabaseService(uid: user.uid).updateUserData( name , project_list);
                        });  
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
                onChanged: (title) { 

                   FirebaseFirestore.instance.collection('projects').doc(widget.project.id).get().then((DocumentSnapshot documentSnapshot) {
                    setState(() { admin_list= List.from(documentSnapshot["admin_ids"]); });
                    setState(() { uid_list= List.from(documentSnapshot["user_ids"]); });
                    DatabaseService(uid: user.uid).updateProjectData( project.id, title, project.text, uid_list,/*CollectionReference tasks,*/  admin_list, project.visible);
                  });
                }
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
                onChanged: (text) { 
                  FirebaseFirestore.instance.collection('projects').doc(widget.project.id).get().then((DocumentSnapshot documentSnapshot) {
                    setState(() { admin_list= List.from(documentSnapshot["admin_ids"]); });
                    setState(() { uid_list= List.from(documentSnapshot["user_ids"]); });
                    DatabaseService(uid: user.uid).updateProjectData( project.id, project.title,text, uid_list,  admin_list, project.visible);
                  });
                  
                }
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
            RaisedButton.icon(
              color: Colors.blueAccent,
              onPressed: (){
                setState(() {
                  visible = !visible;
                }); 
                 FirebaseFirestore.instance.collection('projects').doc(widget.project.id).get().then((DocumentSnapshot documentSnapshot) {
                    admin_list= List.from(documentSnapshot["admin_ids"]); 
                    uid_list= List.from(documentSnapshot["user_ids"]);
                    DatabaseService(uid: user.uid).updateProjectData( project.id, project.title,project.text, uid_list,admin_list, !project.visible);
                  });
                  Navigator.pop(context);
              },
              icon: visible
                ?Icon(Icons.lock , color: Colors.white,)
                :Icon(Icons.lock_open , color: Colors.white,),
              label:visible
                ?Text("Make Private",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                :Text("Make Public",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10,),


            
          ],
        ),
      ),
    );
  }
}

