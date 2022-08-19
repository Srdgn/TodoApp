import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import "package:todoapp/screens/login.dart";
import "package:todoapp/screens/homepage.dart";
import 'package:todoapp/models/user.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return either homepage or loginpage
    final user = Provider.of<MyUser?>(context);

    if(user == null){
      return LoginPage();
    }
    else {
      return Homepage();
    }
    
  }
}