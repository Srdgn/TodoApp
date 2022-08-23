import 'package:flutter/material.dart';
import 'package:todoapp/screens/homepage.dart';
import 'package:todoapp/service/auth.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/screens/projectsPage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  AuthService _auth = new AuthService();

  final padding = EdgeInsets.symmetric(horizontal: 30);
  @override
  Widget build(BuildContext context) {
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
              text: "Users",
              icon: Icons.person_rounded,
              ontap:() async {
              },
            ),
            buildMenuItem(
              text: "Settings",
              icon: Icons.settings_rounded,
              //ontap:
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
