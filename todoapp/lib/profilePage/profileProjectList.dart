import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/home/user_tile.dart';
import 'package:todoapp/projectsPage/projectTile.dart';
import 'package:todoapp/models/project.dart';
import 'profileProjectTile.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/service/database.dart';

class ProfileProjectList extends StatefulWidget {
  String user_id;
  ProfileProjectList({required this.user_id});
  @override
  _ProfileProjectListState createState() => _ProfileProjectListState();
  String getName(String user_id){
      FirebaseFirestore.instance.collection('users').doc(user_id).get().then((DocumentSnapshot documentSnapshot) {
        _ProfileProjectListState.name = documentSnapshot["name"];
    });
    return _ProfileProjectListState.name;
  }
}

class _ProfileProjectListState extends State<ProfileProjectList> {
  @override
  static String name = "";
  
  Future<void> _showAddAdmin(){
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
      return showDialog<void>(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Make Admin On A Project',style: TextStyle(fontWeight: FontWeight.bold)),
            actions: <Widget>[
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_copy_rounded),
                      SizedBox(width: 25),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                        builder: (context, snapshot) {
                          
                            final data = snapshot.data!['projects'];
                            return Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(0xFF221F1F),
                              ),
                              child: DropdownButtonFormField(
                                style: TextStyle(color: Colors.white70),                                               
                                value: _value,
                                items: data
                                    .map<DropdownMenuItem<String>>(
                                      (x) => DropdownMenuItem(
                                        child: textCustom(
                                            x, Colors.white, 16, 'Montserrat'),
                                        value: '${x}',
                                      ),
                                    )
                                    .toList(),
                              
                                onChanged: (val) => setState(() {
                                  _value = val;
                            
                                }),
                              ),
                            );
                          },
                        
                      )
                    ],
                  ),
                  SizedBox(height: 100,),
                    IconButton(
                      alignment:Alignment.bottomCenter,
                      color: Colors.red,
                      icon: Icon(Icons.close_rounded),
                      
                      onPressed: ()async{
                        Navigator.pop(context);
                      },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
    

  
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    bool visible = uid != widget.user_id;  // visible add admin button
    final projects = Provider.of<List<Project>>(context);
    List<Project> project_list = projects.toList();

    
    
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


                "Name: "+widget.getName(widget.user_id),
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 20,
                ),
              ),
               SizedBox(height: 20),
              Center(
                
                child: visible?RaisedButton.icon(
                    color: Colors.white.withOpacity(0.5),
                    icon:Icon(Icons.add_moderator_rounded ,color: Colors.blueGrey),
                    label:Text("Make Admin", style:  TextStyle(fontWeight:FontWeight.bold ,fontSize: 20,color:Colors.blueGrey),),
                    onPressed: () async {
                      _showAddAdmin();
                    },
                ):null,
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
                      
                      return ProfileProjectTile(project: projects[index], projectUser_id: widget.user_id);
                      
                    },
                    ),
                ),
              ),
            ],
          ),
      );
  }
}





