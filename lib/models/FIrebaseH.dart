import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home/models/usermodel.dart';

class FirebaseH{
  static Future<UserModel?> getUserModelById(String uid) async{
    UserModel? userModel;
 DocumentSnapshot docSnap=
  await  FirebaseFirestore.instance.collection("users").doc(uid).get();

 if(docSnap.data()!=null){
   userModel= UserModel.fromMap(docSnap.data() as Map<String,dynamic>);
   return userModel;
 }
  }
}