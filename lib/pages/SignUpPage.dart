import 'package:fluttertoast/fluttertoast.dart';

import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/models/usermodel.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/completeProfilePage.dart';

import 'package:home/services/Auth_Service.dart';

import 'globals.dart';

class SignUpPage extends StatefulWidget{
  SignUpPage({super.key });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   //firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();



  void checkValues() {
    String email = _emailController.text.trim();
    String password = _pwdController.text.trim();


    if (email == "" || password == "" ) {
      print("please fill all the fields");
      Fluttertoast.showToast(
          msg: "Please fill all the details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if (password.length<6){
      Fluttertoast.showToast(
          msg: "password length should be\n greater than 6",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
      else {
        signup(email, password);

      }
    }


  void signup(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password);
      checkpwd=password;
      if (credential != null) {
        String uid = credential.user!.uid;
        UserModel newUser = UserModel(
          uid: uid,
          email: email,
          fullname: " ",
          profilepic: " ",
        );
        await FirebaseFirestore.instance.
        collection("users").doc(uid).set(newUser.toMap()).
        then((value) {
          print("new user created");
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
           return CompleteProfile(userModel: newUser, firebaseUser: credential!.user!);
            }));
      }
    }on FirebaseAuthException catch (ex) {
      print(ex.code.toString());
    }

  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 830,
            width: 500,
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up Page",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline

                  ),),
                SizedBox(height: 20,),

                //   Padding(
                // padding: const EdgeInsets.only(top: 10),
                //     child: buttonItem("lib/images/googleIcon.png","continue with google",25,
                //)),


                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: textItem("Email...", _emailController, false),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: textItem("Password...", _pwdController, true),
                ),



                SizedBox(height: 20,),
                CupertinoButton(child: Text("sign Up"),
                    color: Colors.black, onPressed: () {
                      checkValues();

                }
                    ),


                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("If you already have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(
                              builder: (builder) => LoginPage()),
                                  (route) => false);
                        },
                        child:
                        Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],),
                ),
              ],
            ),
          ),
        ),

      );
    }
  }


  Widget textItem(String labeltext,TextEditingController controller,bool obscureText)
  {
    return Container(
      width: 350,
      height:55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize:17,color: Colors.white,
        ),
        decoration:InputDecoration(
          labelText: labeltext,labelStyle: TextStyle(
          fontSize:17,color: Colors.white,
        ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 1.5,
                color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 1,
                color: Colors.black),
          ),
        ),


      ),
    );
  }



// Widget buttonItem(String imagepath,String buttonName,double size) {
//
//   return InkWell(
//     onTap:(){asyncButtonItem();},
//     child:
//     Container(
//       width: MediaQuery.of(context).size.width - 60,
//       height: 60,
//
//       child: Card(
//         elevation: 8,
//         color: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//           side: BorderSide(
//               width: 1,
//               color: Colors.grey),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               imagepath,
//               height: size,
//               width: size,
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Text(
//               buttonName,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 17,
//               ),),
//           ],
//         ),
//       ),
//     ),
//   );
// }


