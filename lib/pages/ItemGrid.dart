import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:home/data/categories.dart';
import 'package:home/models/category_item.dart';
import 'package:home/pages/ItemPage.dart';
//import 'package:home/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class ItemGrid extends StatefulWidget {
  const ItemGrid({super.key});

  @override
  State<ItemGrid> createState() => ItemGridState();
}

class ItemGridState extends State<ItemGrid> {
  List<CategoryItem> Items = [];
  var _isLoading = true;
 String? _error;

  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() async {
    //load data from firebase
    final url = Uri.https(
        "ourshop-69966-default-rtdb.firebaseio.com", "shopping-list.json");
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = "failed to fetch data. Please try again later.";
        });
      }
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic>listData = json.decode(response.body);
      final List<CategoryItem>loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .
        firstWhere((catItem) => catItem.value.title == item.value['category'])
            .value;
        loadedItems.add(CategoryItem(id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
          image: item.value['image'],
        ));
      }
      //print(response.body);
      setState(() {
        Items = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = "Something went wrong! Please try again later.";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No '));
    if (_isLoading) {
      content = Center(child: CircularProgressIndicator());
    }
    if (Items.isNotEmpty) {
      content =
          Center(
            child: Expanded(
              child: GridView.builder(
              itemCount: Items.length,
              padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.57,),

              itemBuilder: (BuildContext context, int index) {
                return
                    Container(

                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                      ),

                        child: Column(
                          children: [
                            // Container(
                            //   height: 50,
                            //   width: 150,
                              // alignment: Alignment.topRight,
                              // child:
                              // IconButton(
                              //   icon: Icon(Icons.favorite_border, color: Colors.red,),
                              //   onPressed: () {},
                              // ),
                            //),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ItemPage(Items[index],index)),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: CachedNetworkImage(
                                  imageUrl: Items[index].image.toString(),
                                  fit: BoxFit.fitHeight,
                                  placeholder: (context,
                                      url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                height: 120,
                                width: 120,

                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Items[index].name, style: TextStyle(fontSize: 18,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\u{20B9}${Items[index].quantity.toString()}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),),
                                  Icon(Icons.shopping_cart_checkout,
                                    color: Colors.orange,
                                  )
                                ],
                              ),)
                          ],
                        ),
                      );


              }
      ),
            ),
          );
    }
    if(_error!=null){
      content = Center(child:Text(_error!));
    }
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Current Items'),
        //   backgroundColor: Colors.orange,


        body: content
    );


  }
  }
