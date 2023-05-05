// add dependencies cloud_firestore: ^4.5.1
//add dependencies image_picker: ^0.8.7+3
//run  flutter pub add firebase_storage on terminal
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String imgUrl=""; //for storing image in firestore

 late File img= File('images/1.jpg');//initial image

 //String selectedValue= "";//Selected value for dropdown(for choosing category)
// List<String> categories =<String>['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String dropdownValue = 'Dog';

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
                      img==null? Center(child: Text("select image")):Image.file(img),


                FloatingActionButton(
                    child: Icon(Icons.camera_alt,color: Colors.redAccent,),
                    onPressed: ()async{
                      ImagePicker image = ImagePicker();
                      XFile? file= await image.pickImage(source: ImageSource.gallery);
                      //print ('${file?.path}');
                      setState(() {
                        if(file!=null){
                          img=File(file.path);}

                      });
                      String uniqueName=DateTime.now().millisecondsSinceEpoch.toString();

                      Reference referenceRoot= FirebaseStorage.instance.ref();
                      Reference refImg= referenceRoot.child('image');
                      Reference imgToUpload= refImg.child(uniqueName);

                      try{
                        await imgToUpload.putFile(File(file!.path));
                        imgUrl= await imgToUpload.getDownloadURL();
                        //print(imgUrl);
                      }
                      catch(error){
                        AlertDialog(title: Text(error.toString()));
                      }
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
                items: <String>['Dog', 'Books', 'Staionary', 'Daily Use','others...']
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
        child: Text("click"),
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

class chatpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}

class firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("First"),
      ),
    );
  }
}
