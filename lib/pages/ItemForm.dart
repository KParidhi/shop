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
        appBar: AppBar(
          title: Text('Add a new item'),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(

          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                  child: Column(
                      children: [
                        SizedBox(height: 30,),
                        //Text("Add Item", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold,),),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 8,right: 8,bottom: 15),
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
                                radius: 90,
                                child: Image.asset('images/add_pic.png', height: 80,width: 80),

                              ):
                              CircleAvatar(
                                radius: 90,
                                foregroundImage: FileImage(File(profilePic!)),
                              ),
                            ),
                          ),

                        ),
                        Text("Pick an image from gallery....",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          color: Colors.orange),),
                        SizedBox(height: 40,),

                        Container(
                          padding: EdgeInsets.all(8),
                          child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                           children:[
                             TextFormField(
                          onChanged: (value){
                            name = value;},
                          decoration: InputDecoration(

                            labelText: 'Product Name',
                            //hintText: 'enter name',
                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.orange),
                            ),
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
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(

                              labelText: 'Product Price',
                              //hintText: 'enter Price',
                              prefixIcon: Icon(Icons.currency_rupee),

                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.orange),
                            ),
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

                Container(
                  padding:EdgeInsets.only(left: 5,right: 5),
                  child:
                            DropdownButton<String>(
                            // Step 3.
                            value: dropdownValue,
                            icon:Icon(Icons.arrow_drop_down,
                            color: Colors.orange, 


                            ),
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


                          decoration: BoxDecoration(
                            border: Border.all(
                                color:Colors.orange.shade300)
                            //color: Colors.orange.shade300,
                          ),
                ),

                        SizedBox(height: 20,),

                        TextFormField(

                          onChanged: (value3){
                            desc = value3;
                          },

                          decoration: InputDecoration(

                              labelText: 'Product Description (short)',
                              //hintText: 'enter description(Short)',
                              prefixIcon: Icon(Icons.description
                              ),

                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.orange),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        ],),
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


