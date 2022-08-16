import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/user.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


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

  Future register(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}