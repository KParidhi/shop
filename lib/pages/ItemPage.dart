import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/ItemAppBar.dart';
import 'package:home/widgets/ItemBottomNavBar.dart';
import 'package:home/models/category_item.dart';
class ItemPage extends StatelessWidget{
  final CategoryItem Item;
  int index;

  ItemPage(this.Item, this.index);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFEDECF2),
      body: ListView(
        children: [
          ItemAppBar(Item.name),
          Padding(padding: EdgeInsets.all(16),
              child:Image.network(Item.image.toString(),
              height: 300,),
          ),
        Arc(
          edge: Edge.TOP,
          arcType:ArcType.CONVEY,
          height: 30,
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(
                    top:48,
                    bottom: 15,),
                  child: Row(
                    children: [
                      Text(Item.name,   //name
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("description of product(lengthy)",
                      textAlign:TextAlign.justify ,
                    style: TextStyle(
                      fontSize: 17,
                      color:Colors.orange
                    ),),
                  ),
            ],
                 ),
                ),
             ),
           ) ,
    ],),
        bottomNavigationBar:ItemBottomNavBar(Item.price.toString()) ,
          );
  }
}