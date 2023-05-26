

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/pages/CartPage.dart';
import 'package:home/pages/HomePage.dart';
import 'package:home/pages/ItemPage.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:home/pages/splash.dart';
import 'package:home/services/add_product.dart';
import 'package:home/services/products.dart';
import 'package:home/widgets/CartItemSamples.dart';
import 'pages/Categorial_ItemList.dart';
import 'pages/display_item.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
       ProviderScope(child:MyApp()),
  );
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
  '/' // :(ctx)=>ProductsScreen(),
      :(context)=>splash(),
   "cartPage":(context)=>CartPage(),
  //"itemPage":(context)=>ItemPage(),
   "displayItems" : (context)=>DisplayItems(),
    //"Categorical_item":(context)=>CategoryItem(),
},

        );
}
}