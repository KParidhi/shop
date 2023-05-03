import 'package:flutter/material.dart';
class CartBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('\u{20B9}${500}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  )
              )
            ],),
          Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text("Check out", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),

          )
        ],
      ),

    );
  }
}