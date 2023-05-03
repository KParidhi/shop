import 'dart:async';
import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/HomePage.dart';
class splash extends StatefulWidget{
  @override
  State<splash> createState()=>splashState();
}
class splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement((context) as BuildContext,
      MaterialPageRoute(builder: (context) => HomePage()),);
    },
    );
  }


  Widget build(BuildContext context){

  return Scaffold(
    body: Container(
    color: Colors.blue,
      child: Center(
        child: Text("hii",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )

        ),
      ),

    )
  );
  }
}


