import 'package:cloud_firestore/cloud_firestore.dart';
class User2{
  final String name ;
  final String id;
  final List<dynamic> project_ids;

  User2({required this.name, required this.id, required this.project_ids});
}

User2 uidToUser2(String uid){
  FirebaseFirestore.instance.collection('users').doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      String name= documentSnapshot["name"];
      String id = documentSnapshot["id"];
      List<String> project_ids = List.from(documentSnapshot["project_ids"]); 
      return User2(name: name, id: id, project_ids: project_ids);
    });
  return User2(name: "name", id: "id", project_ids: []);

}