import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget{
  String name;
  ItemAppBar(this.name);
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child:Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
            size: 30,
                color: Colors.orange,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20),
            child:Text(name,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color:Colors.orange,
            ),),),
          Spacer(),
          // Icon(Icons.favorite,
          // size:30,
          // color: Colors.orange,)
        ],
      ) ,
    );
  }
}