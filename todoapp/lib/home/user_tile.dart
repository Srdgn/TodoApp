import 'package:flutter/material.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/screens/usersPage.dart';
import 'package:todoapp/screens/profile.dart';

class UserTile extends StatelessWidget {
  final User2 user;
  UserTile({required this.user});
  
  
  @override
  Widget build(BuildContext context) {
    UsersPage.users_names.add(user.name);
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: ButtonWithIcon(user: user),
          title: Text(user.name),
        ),
        ),
      );
  }
}

class ButtonWithIcon extends StatefulWidget {
  User2 user;
  ButtonWithIcon({required this.user});

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  bool checked = false;
  Widget build(BuildContext context) {
    return Ink(
          height: 40,
          width: 40,
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder( ),
          ),
          child: IconButton(
            icon: const Icon(Icons.person),
            color: Colors.white,
            onPressed: () { 
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ProfilePage(user_id: widget.user.id)),
                  );
             },   // see profile 
         ),
        );
  }
}

