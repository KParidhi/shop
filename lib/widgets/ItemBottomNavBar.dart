 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/pages/CartPage.dart';
 class ItemBottomNavBar extends StatefulWidget{
   String price;
   ItemBottomNavBar(this.price);

  @override
  State<ItemBottomNavBar> createState() => _ItemBottomNavBarState();
}

class _ItemBottomNavBarState extends State<ItemBottomNavBar> {
  @override
  Widget build(BuildContext context){
   return BottomAppBar(
     child: Container(
       height:70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(10),
       boxShadow: [
        BoxShadow(
         color: Colors.grey.withOpacity(0.5),
         spreadRadius: 3,
         blurRadius: 10,
         offset: Offset(0,3),
        )
       ]
      ),
      child: Row(
       mainAxisAlignment:MainAxisAlignment.spaceBetween ,
       children: [
        Text('\u{20B9}${widget.price}',
        style: TextStyle(
         fontSize: 25,
         fontWeight: FontWeight.bold,
         color: Colors.orange
        ),),
        // ElevatedButton.icon(onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context)=>CartPage(),
        //   ),);
        // },
        //  icon: Icon(CupertinoIcons.cart_badge_plus),
        //  label: Text("add to Cart",style: TextStyle(
        //   fontSize: 16,fontWeight: FontWeight.bold,
        //  ),
        //  ),
        //  style: ButtonStyle(
        //   backgroundColor: MaterialStateProperty.all(Colors.orange),
        //   padding: MaterialStateProperty.all(
        //    EdgeInsets.symmetric(vertical: 13,horizontal: 15),
        //   ),
        //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //    RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //    )
        //   )
        //  ),
        // ),
       ],
      ),
   )
  );

 }
}






