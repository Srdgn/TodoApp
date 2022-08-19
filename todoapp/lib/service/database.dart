import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/models/user2.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/project.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection("tasks");
  final CollectionReference projectCollection = FirebaseFirestore.instance.collection("projects");//.doc().collection("task");


  //          USERS
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



  //                TASKS
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




  //                PROJECTS
  List<Project> _projectListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      final CollectionReference tasksCollection = FirebaseFirestore.instance.collection("projects").doc(doc.id).collection("tasks");
      return Project(
        id: doc.id,
        title: doc.get("title") ?? "",
        text: doc.get("text") ?? "",
        user_ids: doc.get("user_ids") ?? <String>[],    
        tasks: tasksCollection,                     
        admin_ids: doc.get("admin_ids") ?? <String>[],
        

        );
    }).toList();
  }
  Future updateProjectData(String id,String title, String text, List<String> user_ids,CollectionReference tasks, List<String> admin_ids)async{
    return await taskCollection.doc(id).set({
      "id": id,
      "title": title,
      "text": text,
      "user_ids": user_ids,
      "tasks": tasks,
      "admin_ids": admin_ids
    });
  }
  Stream<List<Project>> get projects{
    return projectCollection.snapshots()
    .map(_projectListFromSnapshot);
  }
}
