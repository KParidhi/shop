import 'package:flutter/material.dart';
class CategoriesWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return
     SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
    children:[
        Container(
    margin:EdgeInsets.symmetric(horizontal: 8.0),
      padding:EdgeInsets.symmetric(vertical: 5,horizontal:10),
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),),
            child:

            Column(
              children:[
                    Image.asset("images/1.jpg",width:40,height: 40,),
                    Text("borla",style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                      color: Colors.orange,
                    )),
                  ],
            ),),
      Container(
        margin:EdgeInsets.symmetric(horizontal: 8.0),
        padding:EdgeInsets.symmetric(vertical: 5,horizontal:10),
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),),
        child:

        Column(
          children:[
            Image.asset("images/2.jpg",width:40,height: 40,),
            Text("kanha",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
              color: Colors.orange,
            )),
          ],
        ),),
      Container(
        margin:EdgeInsets.symmetric(horizontal: 8.0),
        padding:EdgeInsets.symmetric(vertical: 5,horizontal:10),
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),),
        child:

        Column(
          children:[
            Image.asset("images/3.jpg",width:40,height: 40,),
            Text("pouch",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
              color: Colors.orange,
            )),
          ],
        ),),
      Container(
        margin:EdgeInsets.symmetric(horizontal: 8.0),
        padding:EdgeInsets.symmetric(vertical: 5,horizontal:10),
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),),
        child:

        Column(
          children:[
            Image.asset("images/4.jpg",width:40,height: 40,),
            Text("stone",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
              color: Colors.orange,
            )),
          ],
        ),),



    ],),);

  }
}