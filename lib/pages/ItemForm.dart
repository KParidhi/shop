// add dependencies cloud_firestore: ^4.5.1
//add dependencies image_picker: ^0.8.7+3
//run  flutter pub add firebase_storage on terminal
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home/services/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home/services/firebase_services.dart';
import 'dart:core';


void main() {
  runApp(MaterialApp(title: "API", home: ItemForm()));
}

class ItemForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return page();
    //throw UnimplementedError();
  }
}

class page extends State<ItemForm> {

  String name = "",col ="",price="";

  CollectionReference OurShop = FirebaseFirestore.instance.collection("item");
  String? imgUrl=""; //for storing image in firestore

 File? img;//initial image

 //String selectedValue= "";//Selected value for dropdown(for choosing category)
// List<String> categories =<String>['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String dropdownValue = 'Books';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(30.0),
            child: Column(children: [
            Expanded(
              child:Container(

                width:300,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.redAccent)
                ),

                child: Center(
                  child: Column(
                    children:[
                     // img==null? Center(child: Text("select image")):Image.file?(img),


                FloatingActionButton(
                  backgroundColor: Colors.orange,
                    child: Icon(Icons.image,color: Colors.white,),
                    onPressed: ()async {
                      ImagePicker image = ImagePicker();
                      XFile? file = await image.pickImage(
                          source: ImageSource.gallery);
                      //print ('${file?.path}');
                      setState(() {
                        if (file != null) {
                          img = File(file.path);
                        }
                      });
                      ImageInput();



                      //firebase_services me iska code hai
                      imgUrl =await FirebaseServices.getImage(file);
                      print(imgUrl);
                    }),

              ]),),),),
              TextField(
                  onChanged: (value){
                      name = value;},
                      decoration: InputDecoration(

                      labelText: 'Product Name',
                       hintText: 'enter name',
                        prefixIcon: Icon(Icons.drive_file_rename_outline),

                         border: OutlineInputBorder()
        ),
    ),
              TextField(
                  onChanged: (value1){
                    price = value1;

                  },
                  decoration: InputDecoration(

                  labelText: 'Product Price',
                  hintText: 'enter Price',
                  prefixIcon: Icon(Icons.money),

                  border: OutlineInputBorder()
              ),),
              SizedBox(
                height: 16,
              ),

              DropdownButton<String>(
                // Step 3.
                value: dropdownValue,
                isExpanded:true,
                  borderRadius: BorderRadius.circular(20),
                  //border: Border.all(color: Colors.redAccent),
                // Step 4.
                items: <String>[ 'Books', 'Stationary','Electronics', 'Daily Use','others...']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),

              TextField(

                  onChanged: (value3){
                    col = value3;
                  },

                decoration: InputDecoration(

                  labelText: 'Product color',
                  hintText: 'enter colour',
                  prefixIcon: Icon(Icons.color_lens_outlined),

                  border: OutlineInputBorder()
              ),
                  ),
              SizedBox(
                height: 16,
              ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange
          ),
        child: Text("click"),

    //yahan pe data add ho rha hai firestore me
    onPressed:() async {
    await OurShop.add({ 'ProductName': name,
      'ProductPrice' : price,
      'ProductColor': col,
      'Category': dropdownValue,
      'image': imgUrl,
    } );
    //_reference.add(dataToSend);

    }
    )
            ]),),);



  }
}

class cartpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Cart"),
      ),
    );
  }
}



