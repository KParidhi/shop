
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/models/usermodel.dart';
import 'package:home/pages/CartPage.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/display_item.dart';
import 'package:home/pages/globals.dart';
import 'package:home/pages/profile_screen.dart';
import 'package:home/widgets/CategoriesWidget.dart';
import 'package:home/widgets/search.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:home/widgets/HomeAppBar.dart';


void main(){runApp(
    MaterialApp(
        title:"Home Screen",
        home:HomeBody())
);}
class HomeBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return HomeScreen();
    //throw UnimplementedError();
  }

}

class HomeScreen extends State<HomeBody> {

late String email;

@override
void initState(){
  super.initState();

 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawer(
          child:Column(
              children:
              <Widget>[
                Container(
                  color: Colors.orange,
                  width: double.infinity,
                  child:Column(
                    children:
                    <Widget>[
                      SizedBox(height: 40,),

                     CircleAvatar(
                       backgroundImage:
                       Image.network(pimage).image,
                       radius: 60,
                     ),

                      SizedBox(height: 20,),
                      Text("$pname",
                        style: TextStyle(fontSize: 25,
                            color: Colors.white),),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
                ListTile(
                    title: Text("My Orders"),
                    leading: Icon(Icons.shopping_bag_outlined),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context,MaterialPageRoute(builder:(context) => CartPage()));
                    }

                ),
                ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context,MaterialPageRoute(builder:(context) => ProfileScreen()));
      }
                ),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.sell)
                ),
                ListTile(
                  title: Text("Log Out"),
                  leading: Icon(Icons.logout),
                  onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context,
                          (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)
                      {return LoginPage();
                      }
                      )
                  );
                  },
                )
              ]

          )
      ),
      body:
     Column(
          children: [
                // Container(
                //   child: ListView(
                //     shrinkWrap: true,
                //       physics: NeverScrollableScrollPhysics(),
                //       children: [
                        HomeAppBar(),
                        // Expanded(
                        //   child:
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




])
                          );
  }
}
