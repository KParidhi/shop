

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/CartPage.dart';
import 'package:home/pages/HomePage.dart';
import 'package:home/pages/ItemPage.dart';
import 'package:home/pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:home/widgets/CartItemSamples.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  void signup() async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: "nehakaushik1000@gmail.com", password: "123456");
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
theme: ThemeData(
  scaffoldBackgroundColor: Colors.white,

),

      routes: {
  '/':(context)=>HomePage(),
  "cartPage":(context)=>CartPage(),
  "itemPage":(context)=>ItemPage(),
},

        );
}
}