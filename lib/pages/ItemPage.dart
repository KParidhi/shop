import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/ItemAppBar.dart';
import 'package:home/widgets/ItemBottomNavBar.dart';
class ItemPage extends StatelessWidget{
  final String name,img,price;

  ItemPage(this.name, this.img, this.price);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFEDECF2),
      body: ListView(
        children: [
          ItemAppBar(name),
          Padding(padding: EdgeInsets.all(16),
              child:Image.network(img,
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
                      Text(name,   //name
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
        bottomNavigationBar:ItemBottomNavBar(price) ,
          );
  }
}