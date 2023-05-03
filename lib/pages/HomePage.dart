

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/services/camera.dart';
import 'package:home/widgets/CartItemSamples.dart';

import 'package:home/widgets/CategoriesWidget.dart';
import 'package:home/widgets/HomeAppBar.dart';
import '../widgets/ItemsWidget.dart';
class HomePage extends StatefulWidget{
  HomePage({super.key});
  @override
  State<HomePage> createState() =>_HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: Drawer(
          child:Column(
              children:
              <Widget>[
                Container(
                  color: Colors.orange,
                  width: double.infinity,
                  child:Column(
                    children:
                    <Widget>[
                      Container(
                          width: 100,
                          height:180,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("https://th.bing.com/th/id/OIP.1dzpxcuf7LgyKLgNtp6zhQHaFA?pid=ImgDet&rs=1"),
                                fit:BoxFit.fill,
                              )
                          )
                      ),
                      Text("Name",
                        style: TextStyle(fontSize: 25,
                            color: Colors.white),),
                    ],
                  ),
                ),
                ListTile(
                    title: Text("My Orders"),
                    leading: Icon(Icons.shopping_bag_outlined),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context,MaterialPageRoute(builder:(context) => CartItemSamples()));
                    }

                ),
                ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings)
                ),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.sell)
                ),
                ListTile(
                    title: Text("Log Out"),
                    leading: Icon(Icons.logout),
                  onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                )
              ]

          )
      ),


      body:
      ListView(
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
    );

  }

}





