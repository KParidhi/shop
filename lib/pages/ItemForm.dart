// add dependencies cloud_firestore: ^4.5.1
//add dependencies image_picker: ^0.8.7+3
//run  flutter pub add firebase_storage on terminal
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home/services/camera.dart';
import 'package:home/widgets/category_list.dart';
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
  String? productPic;

  String name = "",desc ="",price="", mobile="";
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
                        SizedBox(height: 20,),
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
                                  productPic = file.path;
                                });
                              }
                              // imgUrl =await FirebaseServices.getImage(file);

                            },
                            child: Container(
                              child: productPic==null? CircleAvatar(
                                backgroundColor:Colors.deepOrangeAccent,
                                radius: 70,
                                child: Image.asset('images/add_pic.png', height: 80,width: 80),

                              ):
                              CircleAvatar(
                                radius: 70,
                                foregroundImage: FileImage(File(productPic!)),
                              ),
                            ),
                          ),

                        ),
                        SizedBox(height: 10,),
                        Text("pick an image....",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),),
                        SizedBox(height: 20,),

                        Container(
                          width: 360,
                          child:Column(
                            children: [

                          TextFormField(
                            onChanged: (value){
                              name = value;},
                            decoration: InputDecoration(

                              labelText: 'Product Name',
                              labelStyle: TextStyle(
                                color: Colors.orange
                              ),
                              hintText: 'enter name',
                              prefixIcon: Icon(Icons.drive_file_rename_outline,
                              color: Colors.orange,),

                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: Colors.orange,
                                  ),
                                ),),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },

                          ),

                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value1){
                            price = value1;

                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                              labelText: 'Product Price',
                              labelStyle: TextStyle(
                                  color: Colors.orange
                              ),
                              hintText: 'enter Price',
                              prefixIcon: Icon(Icons.currency_rupee,
                                color:Colors.orange ,),

                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter price';
                            }
                            return null;
                          },

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value){
                            mobile = value;
                            },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(


                            labelText: 'Your Phone no',
                            labelStyle: TextStyle(
                                color: Colors.orange
                            ),
                            hintText: 'enter your phone no.',
                            prefixIcon: Icon(Icons.phone_android,
                            color: Colors.orange,),

                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.orange,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty||value.trim().length!=10
                            ) {
                              return 'Enter a 10 digit mobile number';
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
                              labelStyle: TextStyle(
                                  color: Colors.orange
                              ),
                              hintText: 'enter description(Short)',
                              prefixIcon: Icon(Icons.description,
                              color: Colors.orange,),

                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter price';
                            }
                            return null;
                          },
                        ),
              ])

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
                              productPic==null?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select a Picture')))
                                  : saveInfo();
                            }
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (builder)=>CategoryList()),
                                    (route) => false);
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
    FirebaseServices.getImage(File(productPic!)).whenComplete(() async {
      imgUrl=await FirebaseServices.getImage(File(productPic!));
      Map<String, dynamic> data={ 'ProductName': name,
        'ProductPrice' : price,
        'ProductDesc': desc,
        'Category': dropdownValue,
        'image': imgUrl,
        'mobile': mobile,
      };
      OurShop.add(data);

    });

  }
}


