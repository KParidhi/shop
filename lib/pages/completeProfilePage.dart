import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home/pages/HomePage.dart';
import 'package:home/pages/LoginPage.dart';
import 'package:home/pages/globals.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/usermodel.dart';
class CompleteProfile extends StatefulWidget {
   final UserModel userModel;
   final User firebaseUser;
  const CompleteProfile({Key? key,required this.userModel,required this.firebaseUser}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {

  TextEditingController fullNameController = TextEditingController();
   File? imageFile;

  void selectImage(ImageSource source) async{
   XFile? pickedFile = await ImagePicker().pickImage(source: source);
   if(pickedFile!=null)
     {
        cropImage(pickedFile);
     }
  }

  void cropImage(XFile file) async{
 CroppedFile? croppedImage= await ImageCropper().
 cropImage( sourcePath:file.path,
     aspectRatio:CropAspectRatio(ratioX: 1, ratioY: 1),
 compressQuality: 10) ;
 File convertedFile = File(croppedImage?.path??'');

 if(convertedFile!=null){
setState(() {

  imageFile=convertedFile ;
});
 }
  }

  void checkValues() {
    String fullname = fullNameController.text.trim();
    if(fullname==""||imageFile==null){
      Fluttertoast.showToast(
          msg: "Please fill all the fields!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Uploading data....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print("uploading data...");

      uploadData();
    }
  }

void uploadData()async{
   UploadTask uploadTask= FirebaseStorage.instance.
   ref("profilepictures").
   child(widget.userModel.uid.toString()).putFile(imageFile!);

   TaskSnapshot snapshot = await uploadTask;

   String imageUrl = await snapshot.ref.getDownloadURL();
   String fullname=fullNameController.text.trim();

   widget.userModel.fullname=fullname;
   widget.userModel.profilepic=imageUrl;

    await FirebaseFirestore.instance.collection("users")
        .doc(widget.userModel.uid).set(widget.userModel.toMap()).
    then((value){
   pimage = imageUrl;
   pname=fullname;
     Fluttertoast.showToast(
         msg: "Data uploaded!",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         textColor: Colors.white,
         fontSize: 16.0
     );
     print("data uploaded......");

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder)=>HomePage()),
              (route) => false);
   });
}

  void showPhotoOptions(){
    showDialog(context: context, builder: (context){
return AlertDialog(

  title: Text("Upload profile picture"),
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        leading:Icon(Icons.photo
        ) ,
        title:Text("choose from gallery") ,
        onTap: (){
          Navigator.pop(context);
       selectImage(ImageSource.gallery);
        },
      ),
      ListTile(
      leading: Icon(
        Icons.camera_alt
      ),
        title:Text("take a picture ") ,
        onTap: (){
          Navigator.pop(context);
          selectImage(ImageSource.camera);
        },
      )
    ],
  ),
);
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: Colors.orange,
  title:Center(child: Text("Complete profile")),
),
      body: Padding(
        padding: const EdgeInsets.only(left:50,right: 50),
        child: Container(
          alignment: Alignment.center,

          child: ListView(
            children: [
              SizedBox(height: 40,),
              CupertinoButton(onPressed: (){
                showPhotoOptions();
              },
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  backgroundImage:
                  (imageFile!=null)?
                  FileImage(imageFile!)
                      :null
                  ,
                  backgroundColor: Colors.orange,
                  radius: 80,
                  child:(imageFile==null)?
                  Icon(Icons.person,size:60,
                  color: Colors.white,)
                      :null
                  ,
                ),
              ),
              SizedBox(height: 50,),
              TextFormField(
                controller: fullNameController,

                decoration: InputDecoration(

                  labelText: "full name",
                ),
              ),

              SizedBox(height: 40,),
              CupertinoButton(
                  child: Text("submit"),
                  color:Colors.orange,onPressed: (){
                    checkValues();
                    // Navigator.pushAndRemoveUntil(context,
                    //     MaterialPageRoute(builder: (builder)=>LoginPage()),
                    //         (route) => false);

                  }),
            ],
          ),

        ),
      ),
    );
  }
}


