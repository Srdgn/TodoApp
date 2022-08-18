import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/service/database.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/models/task.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;


  MyUser? _userFromFirebaseUser(User? user){

    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser> get user{
    return _auth.authStateChanges()
      .map((User? user)=>_userFromFirebaseUser(user!)!);
  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
    
  }
  Future signIn(String email, String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password, String name)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;

      await DatabaseService(uid: user!.uid).updateUserData(name);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future newTask(String id,String title, String text, String uid, bool checked)async{
    try{
      final User? user = auth.currentUser;
      await DatabaseService(uid: user!.uid).updateTaskData(id ,title ,text, uid, checked);
      return ;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}