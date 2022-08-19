import 'package:flutter/material.dart';
import 'signup.dart';
import "homepage.dart";
import 'package:todoapp/service/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  String error = '';

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
                       onChanged: (String email){

                       },
                       validator: (email){
                        return email!.isEmpty ? "Please enter an email" : null;
                       },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      //validator: (val)=>val.length < 6 ? "Şifre 6 karakterden uzun olmalı!": null,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(),
                       ),
                       onChanged: (String password){

                       },
                       validator: (password){
                        return password!.isEmpty ? "Please enter an password" : null;
                       },
                    ),
                    

                    SizedBox(height: 20,),

                    
                    MaterialButton(
                      minWidth: double.infinity,
                        onPressed: ()async{ 
                          dynamic result = await _auth.signIn(mailController.text, passwordController.text);
                          if(result == null){
                            setState(() {
                              error = "Giriş İşlemi Başarısız";
                            });
                          }
                          else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  Homepage()),
                            );
                          }     
                        },
                        child: Text("Login",style: TextStyle(fontSize: 20),),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      ),
                    SizedBox(height: 20,),

                    Text("Hesabınız yok mu? Hemen kayıt olun!"),

                    MaterialButton(

                        onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );},
                        child: Text("Sign Up",style: TextStyle(fontSize: 20),),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      ),
                    SizedBox(height: 20,),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 12),
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