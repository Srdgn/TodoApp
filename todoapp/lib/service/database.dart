import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:todoapp/models/user.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/models/task.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection("tasks");

  Future updateUserData(String name)async{
    return await userCollection.doc(uid).set({
      "name": name,
      
    });
  }
  Stream<List<User2>> get users{
    return userCollection.snapshots()
    .map(_userListFromSnapshot);
  }

  List<User2> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return User2(
        name: doc.get("name") ?? "",
        );
    }).toList();
  }


  Future updateTaskData(String id,String title, String text, String uid_task , bool checked)async{
    return await taskCollection.doc(id).set({
      "id": id,
      "title": title,
      "text": text,
      "uid": uid_task,
      "checked": checked,
    });
  }
  Stream<List<Task>> get tasks{
    return taskCollection.snapshots()
    .map(_taskListFromSnapshot);
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
        id: doc.id,
        title: doc.get("title") ?? "",
        text: doc.get("text") ?? "",
        uid: doc.get("uid") ?? "",
        checked: doc.get("checked") ?? "",
        );
    }).toList();
  }


  Future deleteTaskData(String id)async{
    return await taskCollection.doc(id).delete();
  }


}
