

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:home/chat.dart';
import 'package:home/pages/CartPage.dart';
import 'package:home/pages/HomePage.dart';
import 'package:home/pages/ItemPage.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/SignUpPage.dart';
import 'package:home/pages/completeProfilePage.dart';

import 'package:home/pages/splash.dart';
import 'package:home/services/add_product.dart';
import 'package:home/services/products.dart';
import 'package:home/widgets/CartItemSamples.dart';
import 'pages/Categorial_ItemList.dart';
import 'pages/display_item.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    print(value);
    });
  runApp(
      //MyApp()
       ProviderScope(child:MyApp()),
  );
}
class MyApp extends StatefulWidget{
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,

        ),

        routes: {
          // '/' // :(ctx)=>ProductsScreen(),
          '/': (context) => LoginPage(),
          // "cartPage": (context) => CartPage(),
          // //"itemPage":(context)=>ItemPage(),
          // "displayItems": (context) => DisplayItems(),
          //"Categorical_item":(context)=>CategoryItem(),


          // StreamBuilder(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (ctx, snapshot) {
          //     if (snapshot.hasData) {
          //       return HomePage();
          //     }
          //     return LoginPage();
          //   },
          // ),
        },

      );
    }
  }