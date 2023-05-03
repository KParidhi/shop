import 'package:flutter/material.dart';
class CartAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
color: Colors.white,
      padding: EdgeInsets.all(25),
      child:Row(children: [
        InkWell(
          onTap: (){
            //goes back to previous screen/page
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
              color: Colors.orange,
          ),
        ),
Padding(padding: EdgeInsets.only(left: 20),
    child: Text(
    "Cart",
    style: TextStyle(
      color:Colors.orange,
    fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
    ),
),
        Spacer(),
        Icon(Icons.more_vert,size:30,
        color: Colors.orange,)
      ],)
    );

  }
}