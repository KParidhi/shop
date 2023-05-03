import 'package:flutter/material.dart';
import 'package:home/widgets/CartAppBar.dart';
import 'package:home/widgets/CartBottomNavBar.dart';
import 'package:home/widgets/CartItemSamples.dart';
class CartPage extends StatefulWidget{
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context){
return Scaffold(
  body:ListView(
    children: [
      CartAppBar(),
      Container(
        height: 1000,
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Color(0xFFEDECF2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )
        ),
        child: Column(
          children:[
               CartItemSamples(),
      ],),),],
  ),
  bottomNavigationBar: CartBottomNavBar(),
);


  }
}