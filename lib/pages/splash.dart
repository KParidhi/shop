import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/pages/HomePage.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/SignUpPage.dart';

class splash extends StatefulWidget{
  @override
  State<splash> createState()=>splashState();
}
class splashState extends State<splash> with SingleTickerProviderStateMixin {
 late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: Duration(
      milliseconds: 400),
      lowerBound: 0,
      upperBound: 1,
    );
_animationController.forward();
  
  }
  
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){



  return Container (
child:
AnimatedBuilder(
      animation:_animationController ,
      child:  Container(
        color: Colors.orange,
        child: Center(
          child:

          // SvgPicture.asset("images/splash.gif",
          // height: 200,
          // width: 200,)
          Text("hii!",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )

          ),
        ),
      ),

     builder: (context,child)=>
          Padding(
         child: child,
         padding:EdgeInsets.only(
             top:100-_animationController.value*100,
      )
    )
),
  );
  }
}


