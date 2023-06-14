import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home/pages/ItemPage.dart';
//this page displays items in a grid view

class DisplayItems extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Next();
  }
}
class Product {
  final String name;
  final String price;
  final String imageUrl;
  final String desc;
  final String mobile;

  Product({required this.name, required this.price, required this.imageUrl, required this.desc,required this.mobile});
}

class Next extends State<DisplayItems>{

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('item').snapshots();
  //final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return
       SingleChildScrollView(

          child: Container(
            color: Color(0xFFEDECF2),
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return
                      GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.all(8),

                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

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
                              desc: data['ProductDesc'],
                              mobile: data['mobile'],
                            );
                            return
                              Expanded(child:
                              Container(
                                padding: EdgeInsets.only(left:6,right: 6),
                                margin: EdgeInsets.symmetric(vertical:6,horizontal: 6),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ItemPage(name:product.name,price: product.price,imageUrl:product.imageUrl,desc:product.desc,mobile: product.mobile )),
                                        );
                                      },
                                      child:Container(
                                        //margin:EdgeInsets.only(top: 2),
                                        child:CachedNetworkImage(
                                          imageUrl: product.imageUrl,
                                          fit: BoxFit.fitHeight,
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                        height: 170,
                                        width: 130,

                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 25)),
                                    Row(
                                      children: [
                                        Padding(padding: EdgeInsets.only(left: 6)),
                                        Container(
                                          //padding: EdgeInsets.only(bottom: 8),
                                          alignment:Alignment.centerLeft,
                                          child:Text(product.name,style:TextStyle(fontSize:19,
                                            color: Colors.orange,
                                            fontWeight:FontWeight.bold,
                                          ) ,
                                          ),
                                        ),
                                          Spacer(),
                                          Text("\u{20B9}${product.price}",
                                            style:TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ) ,),
                                        Padding(padding: EdgeInsets.only(right: 6))

                                        ],
                                      ),
                                  ],
                                ),
                              ),);}
                      );
                  }
              ),
            ),
          ),

      );
    }}

/*InkWell(
                  onTap: () {
                    // Navigate to the product detail page
                  },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                Expanded(
              // Return a grid tile with the product image

                child: CachedNetworkImage(

                  imageUrl: product.imageUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                ],
              ),
              );
            },
          );
      },
     )));
  }
}*/


/* return Scaffold(
     resizeToAvoidBottomInset: false,
     appBar: AppBar(title: Text("Detail Page")),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Detail Page", style:TextStyle(fontSize: 25,), ),

     FloatingActionButton(
      child: Icon(Icons.arrow_back),
      onPressed: (){
        Navigator.pop(context);
    })*/

