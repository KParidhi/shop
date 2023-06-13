import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/HomePage.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/SignUpPage.dart';
class splash extends StatefulWidget{
  @override
  State<splash> createState()=>splashState();
}
class splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement((context) as BuildContext,
      MaterialPageRoute(builder: (context) => LoginPage()),);
    },
    );
  }


  Widget build(BuildContext context){

  return Scaffold(
    backgroundColor: Colors.orange,
    body: Container(
      child: Center(
        child: Text("hii!",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )

        ),
      ),
    )

  );
  }
}


