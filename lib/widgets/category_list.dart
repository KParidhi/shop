import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home/data/categories.dart';
import 'package:home/models/category_item.dart';
import 'package:home/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryItem> _categoryItems=[];
  var _isLoading=true;
  String? _error;
  void initState(){
    super.initState();
    loadItems();
  }
  void loadItems() async { //load data from firebase
    final url =Uri.https(
        "ourshop-69966-default-rtdb.firebaseio.com","shopping-list.json");
    try {
      final response = await http.get(url);
      if(response.statusCode>=400){
        setState(() {
          _error="failed to fetch data. Please try again later.";
        });
      }
      if(response.body=='null'){
        setState(() {
          _isLoading = false;
        });
        return;
      };
      final Map<String,dynamic>listData=json.decode(response.body);
      final List<CategoryItem>loadedItems = [];
      for(final item in listData.entries){
        final category=categories.entries.
        firstWhere((catItem)=>catItem.value.title==item.value['category']).value;
        loadedItems.add(CategoryItem(id:item.key,
          name:item.value['name'],
          quantity: item.value['quantity'],
          category: category,
          image: item.value['image'],
        ));
      }
      //print(response.body);
      setState(() {
        _categoryItems= loadedItems;
        _isLoading=false;
      });

    }catch(error){
      setState(() {
        _error="Something went wrong! Please try again later.";
      });
    }
    //throw Exception("AN erroe occured!");

  }
  void _addItem() async {

final newItem =
    await Navigator.of(context).push<CategoryItem>(
        MaterialPageRoute(builder: (ctx)=>NewItem()
        ));
    loadItems();
if(newItem==null){
  return;
}
setState(() {
  _categoryItems.add(newItem);
});
  }
  void _removeItem(CategoryItem item)async{
    final index = _categoryItems.indexOf(item);
    setState(() {
      _categoryItems.remove(item);
    });
    final url =Uri.https(
        "ourshop-69966-default-rtdb.firebaseio.com","shopping-list/${item.id}.json");
   final response =  await http.delete(url);
 if(response.statusCode>=400){
   setState(() {
     _categoryItems.insert(index,item);
   });
 }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child:Text('Add an item to sell'));
    if(_isLoading){
      content=Center(child:CircularProgressIndicator());
    }
    if(_categoryItems.isNotEmpty){
      content = ListView.builder(
        itemCount: _categoryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction){
            _removeItem(_categoryItems[index]);
          },
          key: ValueKey(_categoryItems[index].id),
          child: ListTile(
            title: Text(_categoryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _categoryItems[index].category.color,
            ),
            trailing: Text(
              _categoryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }
    if(_error!=null){
      content = Center(child:Text(_error!));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your items'),
          backgroundColor: Colors.orange,
          actions: [
            IconButton(onPressed:
            _addItem,icon: Icon(Icons.add))
          ],
        ),
        body:content
    );
  }
}
