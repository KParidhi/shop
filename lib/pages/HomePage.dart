
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:home/pages/CartPage.dart';
import 'package:home/pages/HomeBody.dart';
import 'package:home/pages/ItemForm.dart';
import 'package:home/pages/display_item.dart';
import 'package:home/services/camera.dart';
import 'package:home/services/products.dart';
import 'package:home/widgets/category_list.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});
  @override
  State<HomePage> createState() =>_HomePageState();

}

class _HomePageState extends State<HomePage> {
  var pagesData = [HomeBody(),CategoryList(),CartPage()];
  int selectedItem = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(

      body:
        pagesData[selectedItem],

      // pagesdata[selectedItem],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,

        height: 60,
        color:Colors.orange ,
        items:[
          Icon(Icons.home,
              size:30,
              color: Colors.white),
          Icon(Icons.add,
            size:30,
            color: Colors.white,),
          Icon(Icons.shopping_cart,
            size:30,
            color: Colors.white,
          ),

        ],
        index: selectedItem,
        onTap: (setValue){

          setState(() {
            selectedItem =setValue;
          });
        },
      ),
    );

  }
}
     /* ListView(
            children: [
                  HomeAppBar(),
                    Container(
                      height:2000,
                      padding:EdgeInsets.only(top:10),
                      decoration: BoxDecoration(
                        color:Color(0xFFEDECF2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child:Column(
                        children:[
                              Container(margin: EdgeInsets.symmetric(horizontal:15 ),
                                padding: EdgeInsets.symmetric(horizontal:10),
                                height: 40,
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),

                               child:Row(
                                     children:[
                                    Container(
                                          margin:EdgeInsets.only(left:5),
                                          height:60,
                                           width:100,
                                        child:TextFormField(
                                          decoration:InputDecoration(
                                           border: InputBorder.none,
                                           hintText: "Search here...",
                                 )
                                ),

                                ),

                           Spacer(),
                  Icon(Icons.camera_alt,
                    size: 27,
                    color: Colors.orange,
                  )
                  ]),

                              ),
    Container(
    alignment:Alignment.centerLeft ,
        padding: EdgeInsets.only(left: 10),
        margin:EdgeInsets.symmetric(
          vertical:20,
          horizontal: 10,),


        child: Text("Categories",
      style:TextStyle(
        fontSize:25,fontWeight: FontWeight.bold,
      color:Colors.orange,),
    ),
    ),
            CategoriesWidget(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child:Text(
                "Latest items",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Colors.orange,
                ),
              ),
            ),
              ItemsWidget(), //Categories
       ]
                      ),
                    )
            ]
                        ),
      bottomNavigationBar:CurvedNavigationBar(
        color: Colors.orange,
        backgroundColor: Colors.orange,
        items:<Widget>[

            Icon(Icons.home,
              size:30,
          color: Colors.white,),

          //Inkwell(
           // onTap:ImageInput(),
           // child:
          Icon(Icons.camera_alt,
            size:30,
           color: Colors.white,
         ),
          Icon(Icons.person,
            size:30,
            color: Colors.white,),

]
      ),
   */







