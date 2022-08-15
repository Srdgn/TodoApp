import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ) ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 32,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold),
              ),

            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                       ),
                       onChanged: (String value){

                       },
                       validator: (value){
                        return value!.isEmpty ? "Please enter an email" : null;
                       },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(),
                       ),
                       onChanged: (String value){

                       },
                       validator: (value){
                        return value!.isEmpty ? "Please enter an password" : null;
                       },
                    ),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            onPressed: (){},
                            child: Text("Login",style: TextStyle(fontSize: 20),),
                            color: Colors.lightBlueAccent,
                            textColor: Colors.white,
                          ),
                          SizedBox(width: 50,),
                        MaterialButton(

                            onPressed: (){},
                            child: Text("Sign In",style: TextStyle(fontSize: 20),),
                            color: Colors.lightBlueAccent,
                            textColor: Colors.white,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}