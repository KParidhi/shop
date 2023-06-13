
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/models/FIrebaseH.dart';

import 'package:home/pages/HomePage.dart';

import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/splash.dart';

import 'models/usermodel.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    print(value);
    });
 User? currentUser=FirebaseAuth.instance.currentUser;
 if(currentUser!=null) {
   UserModel? thisUserModel =
   await FirebaseH.getUserModelById(currentUser.uid);
   if(thisUserModel!=null) {
     runApp(
       ProviderScope(child: MyAppLoggedIn(
         userModel: thisUserModel, firebaseUser: currentUser,)),
     );
   }
   else{
     runApp(ProviderScope(child:MyApp()),);
   }
 }
 else {
   runApp(ProviderScope(child:MyApp()),);
 }

}
class MyApp extends StatelessWidget{
  MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: splash(),



      );
    }
}
class MyAppLoggedIn extends StatelessWidget{
  final UserModel userModel;
  final User firebaseUser;
  MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(userModel:userModel,firebaseUser:firebaseUser,),



    );
  }
}