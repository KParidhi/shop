import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  Product({required this.name, required this.price, required this.imageUrl});
}

class Next extends State<DisplayItems>{

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('item').snapshots();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
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

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,),

            itemBuilder: (BuildContext context, int index) {
              // Get the product data from the Firebase snapshot
              final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // Create a Product object from the data
              final product = Product(
                name: data['ProductName'],
                price: data['ProductPrice'],
                imageUrl: data['image'],
              );
              return InkWell(
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
}


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

