import 'package:flutter/material.dart';
import "login.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      controller: mailController,
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
                      controller: passwordController,
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

                    TextFormField(
                      controller: passwordController2,
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

                    
                    MaterialButton(
                      minWidth: double.infinity,
                        onPressed: (){             
                          if(passwordController.text == passwordController2.text){
                            signUp( mailController.text, passwordController.text);
                          }
                          else{  // aynı olmamalı uyarı
                          }
                        },
                        child: Text("Sign Up",style: TextStyle(fontSize: 20),),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      ),
                    SizedBox(height: 20,),

                    Text("Zaten hesabınız var mı? Giriş yapın!"),

                    MaterialButton(

                        onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );},
                        child: Text("Log In",style: TextStyle(fontSize: 20),),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      ),
                    SizedBox(height: 20,),
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

Future<void> signUp(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }          
  }