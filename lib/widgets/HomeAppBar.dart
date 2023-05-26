import 'package:badges/badges.dart' as badges;
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/CartItemSamples.dart';

class HomeAppBar extends StatefulWidget{
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context){
    return  Container(
      color: Colors.orange,
      padding: EdgeInsets.only(top:25,left: 10,right: 10,bottom: 8),
      child:Row(
        children: [
          IconButton(
            icon:Icon(Icons.sort),
            color:Colors.white,
            onPressed:() =>Scaffold.of(context).openDrawer(),
          ),
          Padding(padding: EdgeInsets.only(left:20),
          child:Text("Our's Shop",
              style:TextStyle(fontSize:24,
                  fontWeight:FontWeight.bold,
              color:Colors.white
              ),
    ),
          ),





        ],
      ),

    );
  }
}