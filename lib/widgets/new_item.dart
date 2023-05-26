
import 'dart:core';
import 'dart:io';



import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/data/categories.dart';
import 'package:home/models/category.dart';
import 'package:home/models/category_item.dart';
import 'package:home/services/firebase_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';


class NewItem extends StatefulWidget{
   NewItem({super.key});



  @override
  State<NewItem> createState(){
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem>
{
  final _formKey = GlobalKey<FormState>();
  var _enteredName=" ";
  var _enteredprice=   100  ;                                       //Text('\u{20B9}${your amount}')
  var _selectedCategory= categories[Categories.books]!;
  var _isSending=false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending=true;
      });
      final url = Uri.https(
          "ourshop-69966-default-rtdb.firebaseio.com","shopping-list.json");
      final response = await http.post(url,headers: {
        "content-type" : "application/json",
      },
        body: json.encode({
          'name':_enteredName,
          'price': _enteredprice,
          'category': _selectedCategory.title,
          'image': imgUrl,

        },),

      );
      print(response.body);
      print(response.statusCode);
      final Map<String, dynamic>resData=  json.decode(response.body);
      if(!context.mounted) {
        return;
      }
      Navigator.of(context).pop(CategoryItem(id:resData['name'],
      name: _enteredName,
          price: _enteredprice,
        category: _selectedCategory,
        image: imgUrl,

      ));
    }
  }
  //String imageUrl='';
  File? _selectedImage;
  String? imgUrl="";
  File? img;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new item'),
        backgroundColor: Colors.orange,
      ),
      body:
      Column(
        children: [
          Padding(
              padding: EdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child:Column(
                    children: [
                       FloatingActionButton(
                           backgroundColor: Colors.orange,
                           child: Icon(Icons.image,color: Colors.white,),
                           onPressed: ()async {
                             ImagePicker image = ImagePicker();
                             XFile? file = await image.pickImage(source: ImageSource.gallery);
                             setState(() {
                               if (file != null) {
                                 img = File(file.path);}
                             });
                             imgUrl =await FirebaseServices.getImage(file);
                           }),
                      TextFormField(
                        maxLength: 50,
                        decoration: InputDecoration(
                          label:Text("name"),
                        ),
                        validator: (value) {
                          if(value==null ||
                              value.isEmpty ||
                              value.trim().length<=1 ||
                              value.trim().length>50){
                            return "must be between 1 and 50 characters ";
                          }
                          return null;
                        },
                        onSaved: (value){
                          _enteredName=value!;
                        },

                      ),
                      Row(
                        children: [
                          Expanded(child:
                          TextFormField(
                            decoration: InputDecoration(
                              label:Text("price: \u{20B9} "),
                            ),
                            keyboardType:TextInputType.number,
                            initialValue:"1" ,
                            validator: (value) {
                              if(value==null ||
                                  value.isEmpty ||
                                  int.tryParse(value)==null ||
                                  int.tryParse(value)!<=0){
                                return "must be a valid price in rupees ";
                              }
                              return null;
                            },
                            onSaved: (value){
                              _enteredprice=int.parse(value!);
                            },
                          ),
                          ),
                          SizedBox(width: 8),
                          Expanded(child:
                          DropdownButtonFormField(items:[
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    SizedBox(width: 6,),
                                    Text(category.value.title),
                                  ],


                                ),)

                          ], onChanged: (value){
                            setState(() {

                            });
                            _selectedCategory=value!;
                          }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                            onPressed:_isSending? null
                                : (){
                              _formKey.currentState!.reset();
                            },
                            style:ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange
                            ) ,
                            child: Text("Reset"),
                          ),SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(onPressed: _isSending?null :_saveItem,
                              style:ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange
                              ) ,
                              child: Text("Add Item"))
                        ],
                      ),

                    ],
                  ),
                ),

              ),



               //IconButton(onPressed: () async {
               // ImagePicker imagePicker = ImagePicker();
               //   XFile? file = await imagePicker.pickImage(
               //       source: ImageSource.camera);
               //   print('${file?.path}');
               //
               //   if (file == null) return;
               //
               //   String uniqueFileName = DateTime
               //       .now()
               //       .millisecondsSinceEpoch
               //       .toString();
               //
               //   Reference referenceRoot = FirebaseStorage.instance.ref();
               //   Reference referenceDirImages = referenceRoot.child('images');
               //   Reference referenceImageToUpload = referenceDirImages.child(
               //       uniqueFileName);
               //   try {
               //     await referenceImageToUpload;   //.putFile(File(file!.path));
               //     imageUrl = await referenceImageToUpload.getDownloadURL();
               //   }
               //   catch (error) {
               //
               //   }
               //   },
               //   icon:Icon(Icons.camera_alt)),
        ],
      ),
    );
  }
}