//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/service/auth.dart';
import 'package:todoapp/service/wrapper.dart';
import 'package:todoapp/user.dart';
import "service/wrapper.dart";
import "package:provider/provider.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  }

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}


