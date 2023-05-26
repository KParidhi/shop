import 'package:flutter/material.dart';
class CartAppBar extends StatefulWidget{
  @override
  State<CartAppBar> createState() => _CartAppBarState();
}

class _CartAppBarState extends State<CartAppBar> {
  @override
  Widget build(BuildContext context){
    return Container(
color: Colors.orange,
      padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
      child:Row(children: [
Padding(padding: EdgeInsets.only(left: 20),
    child: Text(
    "Cart",
    style: TextStyle(
      color:Colors.white,
    fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
    ),
),
        Spacer(),
        Icon(Icons.more_vert,size:30,
        color: Colors.white,)
      ],)
    );

  }
}