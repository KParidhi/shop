import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home/pages/display_item.dart';
import 'package:home/services/firebase_services.dart';
import 'ItemPage.dart';

class CategoryItem  extends StatefulWidget{
    String categories;
    CategoryItem(this.categories);
    @override
    State<StatefulWidget> createState() {
        return CategoryItems();
    }
}

class CategoryItems extends State<CategoryItem> {

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
                title:  Text(widget.categories),
                backgroundColor: Colors.orange,),
            body:
            Container(
                color: Color(0xFFEDECF2),
                child: StreamBuilder(
                    stream: FirebaseServices.getProducts(widget.categories),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                    {
                        if (snapshot.hasError) {
                            return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text("Loading");
                        }
                        else{ return
                            GridView.builder(
                                itemCount: snapshot.data!.docs.length,
                                padding: const EdgeInsets.all(8),

                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 0.58),

                                itemBuilder: (BuildContext context, int index) {
                                    // Get the product data from the Firebase snapshot
                                    final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                                    // Create a Product object from the data
                                    final product = Product(
                                        name: data['ProductName'],
                                        price: data['ProductPrice'],
                                        imageUrl: data['image'],
                                        desc:data['ProductDesc'],
                                        mobile: data['mobile']

                                    );
                                    return
                                        Expanded(child:
                                        Container(
                                            padding: EdgeInsets.only(left:15,right: 15,top: 10),
                                            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                                children: [
                                                    Container(
                                                        height: 50,
                                                        width: 150,
                                                        alignment: Alignment.topRight,

                                                    ),
                                                    InkWell(
                                                        onTap: (){
                                                            //Navigator.pushNamed(context, "itemPage");
                                                            //Get.to(()=> ItemPage(product.name ));
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => ItemPage(name:product.name,price: product.price,imageUrl:product.imageUrl,desc:product.desc,mobile: product.mobile )),
                                                            );
                                                        },
                                                        child:Container(
                                                            margin:EdgeInsets.all(8),
                                                            child:CachedNetworkImage(
                                                                imageUrl: product.imageUrl,
                                                                fit: BoxFit.fitHeight,
                                                                placeholder: (context, url) => Transform.scale(scale: 0.5,
                                                                    child: const CircularProgressIndicator()),
                                                                errorWidget: (context, url, error) => const Icon(Icons.error),),
                                                            height: 120,
                                                            width: 120,

                                                        ),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(bottom: 8),
                                                        alignment:Alignment.centerLeft,
                                                        child:Text(product.name,style:TextStyle(fontSize:18,
                                                            color: Colors.orange,
                                                            fontWeight:FontWeight.bold,
                                                        ) ,
                                                        ),
                                                    ),

                                                    Padding(
                                                        padding: EdgeInsets.symmetric(vertical:10),
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Text("\u{20B9}${product.price}",
                                                                    style:TextStyle(
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.orange,
                                                                    ) ,),
                                                                Icon(Icons.shopping_cart_checkout,
                                                                    color:Colors.orange,
                                                                )
                                                            ],
                                                        ),)
                                                ],
                                            ),
                                        ),);}
                            );}}
                ),
            ),
        );
    }}


