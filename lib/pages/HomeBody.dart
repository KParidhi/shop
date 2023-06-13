

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:home/pages/display_item.dart';

import 'package:home/widgets/CategoriesWidget.dart';
import 'package:home/widgets/search.dart';
class HomeBody extends StatefulWidget{


  const HomeBody({super.key});
  @override
  State<HomeBody> createState()=> _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

late String email;

@override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
     SingleChildScrollView(
       child: Column(
            children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDECF2),
                              ),

                                child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 15),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),

                                        child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                height: 60,
                                                width: 100,
                                                child: TextFormField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Search here ...",
                                                    ),
                                                  onTap: (){
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) =>search()));
                                                      },


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
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        margin: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 10,),


                                        child: Text("Categories",
                                          style: TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.bold,
                                            color: Colors.orange,),
                                        ),
                                      ),
                                      CategoriesWidget(),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Text(
                                          "Latest items",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                      //ItemsWidget(),

                                      // ItemGrid(),
                                    ]
                                ),
                              ),

              //GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
                DisplayItems() ,




]),
     )
                          );
  }
}
