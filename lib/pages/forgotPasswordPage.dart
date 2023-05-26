import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
 final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar:AppBar(
        title: Text("Forgot Password",
        style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: Colors.orange,
      ) ,
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child:
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            height: 400,
            width: 380,
            child: Card(
    color: Colors.white,
    child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                  controller:emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange
                        )
                      )
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange
                    ),
                    onPressed:(){
                  auth.sendPasswordResetEmail(
                      email: emailController.text.toString()).then((value){
                  Fluttertoast.showToast(
                      msg: 'An email has been sent to you for your password recovery');
                  Navigator.of(context).pop();
                  }).onError((error, stackTrace){
                    Fluttertoast.showToast( msg: error.toString()
                       );

                  });
                },
                    child: Text("Reset Password",
                    ))

              ],
            ),
      ),
          ),
        ) ,
      )
    );
  }
}
