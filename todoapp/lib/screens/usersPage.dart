import 'package:flutter/material.dart';
import 'package:todoapp/service/auth.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/service/database.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task.dart';
import 'package:uuid/uuid.dart';
import "package:todoapp/home/navigationDrawer.dart";
import 'package:todoapp/home/editTask.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/home/userList.dart';
import 'package:todoapp/screens/usersPage.dart';

class UsersPage extends StatefulWidget {

  @override
  State<UsersPage> createState() => _UsersPageState();
  static Set<String> users_names = {} ;
}

class _UsersPageState extends State<UsersPage> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  

  @override
  Widget build(BuildContext context) {
    
    
    return StreamProvider<List<User2>>.value(
      initialData: [],
      value: DatabaseService().users,
      child: Scaffold(

          floatingActionButtonLocation: 
            FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                showSearch(
                  context: context,
                   delegate: MySearchDelegate(),
                );
              },
               child: Icon(Icons.search),
            ),   
          appBar: AppBar(
          title: Text(
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30) ,
            'Users'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          actions: <Widget>[
            
            
          ],
        ),
          endDrawer: NavigationDrawerWidget(),
          body: UserList(),
          ),
    );
  }
}



class MySearchDelegate extends SearchDelegate{
  List<String> searchResults = UsersPage.users_names.toList();
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: ()=> close(context,null),
     icon: Icon(Icons.arrow_back));
    
  
  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      onPressed:() {
        if(query.isEmpty){
          close(context,null);
        }
        else query="";
        },
      icon: Icon(Icons.clear))
    ];
  
  @override
  Widget buildResults(BuildContext context) => Center(   //ADD show user profile 
    child:Text(   
      query
    ),
    );
  
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index){
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: (){
            query = suggestion;
            showResults(context);
          },
        );
      }
    );
  }

}



