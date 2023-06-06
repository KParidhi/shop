import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/ItemAppBar.dart';
import 'package:home/widgets/ItemBottomNavBar.dart';
import 'package:home/models/category_item.dart';
class ItemPage extends StatelessWidget{
  // final CategoryItem Item;
  // int index;
  final String name;
  final String price;
  final String imageUrl;
  final String desc;
  final String mobile;

  ItemPage({required this.name, required this.price, required this.imageUrl,  required this.desc, required this.mobile});



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFEDECF2),
      body: ListView(
        children: [
          ItemAppBar(name),
          Padding(padding: EdgeInsets.all(16),
            child:Image.network(imageUrl.toString(),
              height: 300,),
          ),
          // Arc(
          //   edge: Edge.TOP,
          //   arcType:ArcType.CONVEX,
          //   height: 30,
          //child:
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(
                    top:10,
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
                    child: Text(desc,
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

        ],),
      bottomNavigationBar:ItemBottomNavBar(price.toString()) ,
    );
  }
}