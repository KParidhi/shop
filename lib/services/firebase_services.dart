import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import '../const/firebase_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class FirebaseServices{

  static getProducts(category){
    return FirebaseFirestore.instance.collection(productCollection).where('Category', isEqualTo: category).snapshots();

}
  static Future<String?> getImage(file) async{
    String imgUrl="";
   String uniqueName=DateTime.now().millisecondsSinceEpoch.toString();

   Reference referenceRoot= FirebaseStorage.instance.ref();
   Reference refImg= referenceRoot.child('image');
   Reference imgToUpload= refImg.child(uniqueName);

   try{
     await imgToUpload.putFile(File(file!.path));
     imgUrl= await imgToUpload.getDownloadURL();

     return imgUrl ;

   }
   catch(error){
     AlertDialog(title: Text(error.toString()));
   }
 }
 }
