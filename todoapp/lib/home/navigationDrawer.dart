import 'package:flutter/material.dart';
import 'package:todoapp/screens/homepage.dart';
import 'package:todoapp/service/auth.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/screens/projectsPage.dart';
import "package:todoapp/screens/usersPage.dart";
import 'package:todoapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/user2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavigationDrawerWidget extends StatelessWidget {
  AuthService _auth = new AuthService();

  final padding = EdgeInsets.symmetric(horizontal: 30);
  @override
  Widget build(BuildContext context) {


    Future<void> _showSettings(){
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold)),
            actions: <Widget>[
              Row(
                children: [
                 
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



    return Drawer(
      child: Material(
        color: Colors.lightBlue[200],
        child: ListView(
          padding: padding,
          children: <Widget>[
            SizedBox(height: 50,),
            
            buildMenuItem(
              text: "Projects",
              icon: Icons.folder_copy_rounded,
              ontap:() async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ProjectsPage()),
                  ); 
              },
            ),
            buildMenuItem(
              text: "Tasks",
              icon: Icons.task_rounded,
              ontap:() async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Homepage()),
                  );
              },
            ),
            buildMenuItem(
              text: "Profile",
              icon: Icons.person_rounded,
              ontap:() async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final User? user = auth.currentUser;
                final uid = user!.uid;
                
                print(uid);
                Navigator.push(

                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(user_id : uid)),
                  );
                
              },
            ),
            buildMenuItem(
              text: "Users",
              icon: Icons.people_rounded,
              ontap:() async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage()),
                  );
              },
            ),
            buildMenuItem(
              text: "Settings",
              icon: Icons.settings_rounded,
              ontap: () {Navigator.pop(context);
               _showSettings();}
              ),
            SizedBox(height: 10,),
            buildMenuItem(
              text: "Logout",
              icon: Icons.logout_rounded,
              ontap:() async {
                await _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginPage()),
                  );
              },
            ),
          ],
          ),
        ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? ontap,
  }){
    final color = Colors.white;
    return ListTile(
      leading: Icon(icon,color: color),
      title: Text(text, style:  TextStyle(fontWeight:FontWeight.bold ,fontSize: 20,color:color),),
      onTap: ontap,
    );
  }





