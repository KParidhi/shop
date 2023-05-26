// add dependencies cloud_firestore: ^4.5.1
//add dependencies image_picker: ^0.8.7+3
//run  flutter pub add firebase_storage on terminal
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home/services/camera.dart';
import 'package:image_picker/image_picker.dart';

import 'package:home/services/firebase_services.dart';
import 'dart:core';

import 'package:flutter/services.dart';


class ItemForm extends StatefulWidget{
  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  //const ProfileScreen({Key? key}): super(key: key);
  String? profilePic;

  String name = "",desc ="",price="";
  String dropdownValue = 'Books';
  String? imgUrl="";
  bool _isSaving=false;

  CollectionReference OurShop = FirebaseFirestore.instance.collection("item");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(

          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                  child: Column(
                      children: [
                        SizedBox(height: 100,),
                        Text("Add Item", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold,),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: ()async{
                              ImagePicker image = ImagePicker();
                              XFile? file = await image.pickImage(
                                  source: ImageSource.gallery);

                              if(file != null)
                              {
                                setState(() {
                                  profilePic = file.path;
                                });
                              }
                              // imgUrl =await FirebaseServices.getImage(file);

                            },
                            child: Container(
                              child: profilePic==null? CircleAvatar(
                                backgroundColor:Colors.deepOrangeAccent,
                                radius: 70,
                                child: Image.asset('images/add_pic.png', height: 80,width: 80),

                              ):
                              CircleAvatar(
                                radius: 70,
                                foregroundImage: FileImage(File(profilePic!)),
                              ),
                            ),
                          ),

                        ),
                        SizedBox(height: 20,),

                        TextFormField(
                          onChanged: (value){
                            name = value;},
                          decoration: InputDecoration(

                            labelText: 'Product Name',
                            hintText: 'enter name',
                            prefixIcon: Icon(Icons.drive_file_rename_outline),

                            border: OutlineInputBorder(),),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onChanged: (value1){
                            price = value1;

                          },
                          decoration: InputDecoration(

                              labelText: 'Product Price',
                              hintText: 'enter Price',
                              prefixIcon: Icon(Icons.money),

                              border: OutlineInputBorder()
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
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
                        SizedBox(height: 20,),

                        TextFormField(

                          onChanged: (value3){
                            desc = value3;
                          },

                          decoration: InputDecoration(

                              labelText: 'Product Description',
                              hintText: 'enter description(Short)',
                              prefixIcon: Icon(Icons.description),

                              border: OutlineInputBorder()
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange
                          ),

                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              SystemChannels.textInput.invokeMapMethod('TextInput.hide');
                              profilePic==null?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select a Picture')))
                                  : saveInfo();
                            }
                          },
                          child: Text("Add Item"),)
                      ])
              ),
            ),
          ),
        )
    );
  }

  saveInfo() async {
    FirebaseServices.getImage(File(profilePic!)).whenComplete(() async {
      imgUrl=await FirebaseServices.getImage(File(profilePic!));
      Map<String, dynamic> data={ 'ProductName': name,
        'ProductPrice' : price,
        'ProductDesc': desc,
        'Category': dropdownValue,
        'image': imgUrl,
      };
      OurShop.add(data);

    });

  }
}


