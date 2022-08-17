import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:provider/provider.dart";
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/home/user_tile.dart';

class UserList extends StatefulWidget {

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User2>>(context);
    
    
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context , index){
        return UserTile(user: users[index]);
      },
      );
  }
}