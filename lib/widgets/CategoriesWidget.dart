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
                InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "displayItems");
                  },
       child:  Image.asset("images/book.jpg",width:40,height: 40,),),
                    Text("Books",style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                      color: Colors.orange,
                    )),
                  ],)
            ),
      Container(
        margin:EdgeInsets.symmetric(horizontal: 8.0),
        padding:EdgeInsets.symmetric(vertical: 5,horizontal:10),
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),),
        child:

        Column(
          children:[
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, "displayItems");
                },
         child:   Image.asset("images/stationery.png",width:40,height: 40,),),
            Text("Stationery",style:TextStyle(
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
  InkWell(
  onTap: (){
  Navigator.pushNamed(context, "displayItems");
  },
         child:   Image.asset("images/elec.jpg",width:40,height: 40,),),
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
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "displayItems");
                  },
          child:  Image.asset("images/daily.jpg",width:40,height: 40,),),
            Text("Daily Use",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
              color: Colors.orange,
            )),
          ],
        ),


    ),
  Container(
    margin:EdgeInsets.symmetric(horizontal: 8.0),
    padding:EdgeInsets.symmetric(vertical: 5,horizontal:10),
    decoration:BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),),
    child:

    Column(
    children:[
    InkWell(
    onTap: (){
    Navigator.pushNamed(context, "displayItems");
    },
    child:  Image.asset("images/other.png",width:40,height: 40,),),
    Text("Others",style:TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 8,
  color: Colors.orange,
  )),
  ],
  ),

  ),],),)
  ;





  }
}