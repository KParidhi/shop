
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/CartPage.dart';
import 'package:home/pages/HomeBody.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/profile_screen.dart';
import 'package:home/widgets/category_list.dart';
import '../models/usermodel.dart';

class HomePage extends StatefulWidget{
  final UserModel userModel;
  final User firebaseUser;
  HomePage({super.key, required this.userModel, required this.firebaseUser});
  @override
  State<HomePage> createState() =>_HomePageState();

}

class _HomePageState extends State<HomePage> {
  String profilePicUrl="";
  String name="";
  Future<Map<String,String>>getProfileData()
  async{
    DocumentSnapshot documentSnapshot=
    await FirebaseFirestore.instance.collection("users").
    doc(widget.firebaseUser.uid).get();
    if(documentSnapshot.exists){
      Map<String, dynamic> data=
      documentSnapshot.data() as Map<String,dynamic>;
      String profilePic = data["profilepic"];
      String name = data["fullname"];
      return {
        "profilepic":profilePic,
        "name":name,};
    }
    return {"profilepic": '',
      "name":'',
    };
  }

  @override
  void initState(){
    super.initState();
    getProfileData().then((data) {
      setState(() {
        profilePicUrl = data["profilepic"]??'';
        name=data["name"]??'';
      });
    });

  }



  var pagesData = [HomeBody(),
    CategoryList(),CartPage()];
  int selectedItem = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer:Drawer(
        child: FutureBuilder<Map<String,String>>(
            future: getProfileData(),
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else if (snapshot.hasError) {
                return Text('Error loading image');
              } else {
                final profilePicUrl = snapshot.data?["profilepic"] ?? '';
                final name = snapshot.data?["name"] ?? '';

                return Column(
                    children:
                    <Widget>[
                      Container(
                        color: Colors.orange,
                        width: double.infinity,
                        child: Column(
                          children:
                          <Widget>[
                            SizedBox(height: 40,),

                            CircleAvatar(
                              backgroundImage: profilePicUrl.isNotEmpty ?
                              NetworkImage(profilePicUrl) : null,
                              radius: 70,
                            ),

                            SizedBox(height: 20,),
                            Text(name,
                              style: TextStyle(fontSize: 25,
                                  color: Colors.white),),
                            SizedBox(height: 20,)
                          ],
                        ),
                      ),
                      ListTile(
                          title: Text("My Orders"),
                          leading: Icon(Icons.shopping_bag_outlined),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => CartPage()));
                          }

                      ),
                      ListTile(
                          title: Text("Settings"),
                          leading: Icon(Icons.settings),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => ProfileScreen()));
                          }
                      ),
                      ListTile(
                          title: Text("My products"),
                          leading: Icon(Icons.sell)
                      ),
                      ListTile(
                        title: Text("Log Out"),
                        leading: Icon(Icons.logout),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.popUntil(context,
                                  (route) => route.isFirst);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }
                              )
                          );
                        },
                      )
                    ]

                );

              }
            }
        ),
      ),
      appBar: AppBar(
        title: Text("Our's shop"),
        backgroundColor: Colors.orange,),



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







