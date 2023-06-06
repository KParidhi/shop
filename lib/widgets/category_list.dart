
import 'package:flutter/material.dart';
import 'package:home/pages/ItemPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home/pages/ItemForm.dart';



class CategoryList extends StatefulWidget{
  const CategoryList({super.key});

  @override
  State<StatefulWidget> createState() => _categoryList ();

}

class _categoryList  extends State<CategoryList>{
  final CollectionReference item = FirebaseFirestore.instance.collection('item');

  Future<void> _delete(String productId) async {
    await item.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your items'),
          backgroundColor: Colors.orange,
          actions: [
            IconButton(onPressed:
            _addItem

                ,icon: Icon(Icons.add))
          ],
        ),
        body: StreamBuilder(
          stream: item.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Unable to load Items');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  final DocumentSnapshot itemData =snapshot.data!.docs[index];
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text (itemData['ProductName']),
                        subtitle: Text(itemData['ProductPrice'].toString()),
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ItemPage(name:itemData['ProductName'],price: itemData['ProductPrice'],imageUrl:itemData['image'],desc:itemData['ProductDesc'],mobile:itemData['mobile'])),
                          );

                        },
                        trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _delete(itemData.id)
                              ),
                            ],
                          ),
                        ),
                      )

                  );
                });
          }
          ,

        )
    );
  }

  Future<void> _addItem()async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemForm()),
    );
  }
}







