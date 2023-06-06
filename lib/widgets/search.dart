import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home/pages/ItemPage.dart';

class search extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _search();

}

class _search extends State<search>{
  String searchedVal="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Card(

              child: TextField(
                  decoration: InputDecoration(
                    prefixIcon:Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Search here ...",),
                  onChanged: (val){
                    setState(() {
                      searchedVal=val;
                    });
                    print(searchedVal);
                  })



          )
      ),
      body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('item').snapshots(),
        builder: (context,snapshots){
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final List<QueryDocumentSnapshot> data = snapshots.data!.docs;

          List<Widget> searchResults = [];

          for (var itemData in data) {
            var item = itemData.data() as Map<String, dynamic>;

            if (searchedVal.isEmpty ||
                item['ProductName']
                    .toString()
                    .toLowerCase()
                    .contains(searchedVal.toLowerCase())) {
              searchResults.add(
                ListTile(
                    title: Text(
                      item['ProductName'],
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['ProductPrice'].toString(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item['image']),
                    ),
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => ItemPage(name:item['ProductName'],price: item['ProductPrice'],imageUrl:item['image'],desc:item['ProductDesc'],mobile:item['mobile'])),
                      );}
                ),
              );
            }
          }

          return ListView(
            children: searchResults,
          );
        },
      ),
    );
  }
}

//    return (snapshots.connectionState == ConnectionState.waiting)?Center(
//             child: CircularProgressIndicator(),):
//               ListView.builder(
//                   itemCount: snapshots.data!.docs.length,
//                   itemBuilder:(context,index){
//                   final DocumentSnapshot itemData =snapshots.data!.docs[index];
//                   var data = itemData.data() as Map<String, dynamic>;
//
//                   if(searchedVal.isEmpty){
//
//     ListTile(
//   title: Text (data['ProductName'], style: TextStyle(color:Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)),
//
//
// subtitle: Text(data['ProductPrice'].toString(),
//     style: TextStyle(color:Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)
// ),
//     leading: CircleAvatar(
//     backgroundImage: NetworkImage(data['image']),
//     ),
//
//   );
// }
// if(data['ProductName'].toString().toLowerCase().contains(searchedVal.toLowerCase())){
//   print(data['ProductName']);
//   return
//     ListTile(
//       title: Text (data['ProductName'], maxLines: 1,
//           style: TextStyle(color:Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)),
//
//
//       subtitle: Text(data['ProductPrice'].toString(),
//           style: TextStyle(color:Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)
//       ),
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(data['image']),
//       ),
//
//     );
// }
// return Container();
// });
//
// }
//
