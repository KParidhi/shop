import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:home/widgets/CartItemSamples.dart';

class HomeAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return  Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child:Row(
        children: [
          IconButton(
            icon:Icon(Icons.sort),
            color:Colors.orange,
            onPressed:() =>Scaffold.of(context).openDrawer(),
          ),
          Padding(padding: EdgeInsets.only(left:20),
          child:Text("Our's Shop",
              style:TextStyle(fontSize:24,
                  fontWeight:FontWeight.bold,
              color:Colors.orange
              ),
    ),
          ),
          Spacer(),
        badges.Badge(
          badgeContent: Text('3') ,
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.orange,
            padding: EdgeInsets.all(7),
          ),
        ),

          InkWell(
          onTap: () {
            Navigator.pushNamed((context), "cartPage");
          },
          child:Icon(Icons.shopping_bag_outlined,
          size:32,
          color:Colors.black),
          
    )


        ],
      ),
      
    );
  }
}