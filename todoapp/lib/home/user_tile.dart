import 'package:flutter/material.dart';
import 'package:todoapp/models/user2.dart';

class UserTile extends StatelessWidget {
  final User2 user;
  UserTile({required this.user});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: ButtonWithIcon(),
          title: Text(user.name),
        ),
        ),
      );
  }
}

class ButtonWithIcon extends StatefulWidget {
  const ButtonWithIcon({Key? key}) : super(key: key);

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  bool checked = false;
  Widget build(BuildContext context) {
    return IconButton(
            icon: checked 
                ? Icon(Icons.check_box_outlined)
                : Icon(Icons.check_box_outline_blank),
            onPressed: () {
              setState((){
                checked = !checked;
              });
            },
          );
  }
}

