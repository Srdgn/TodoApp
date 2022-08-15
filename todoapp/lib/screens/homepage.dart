import 'package:flutter/material.dart';



class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/logo.png"))
            ],
          )
          ) 
        );
  }
}



