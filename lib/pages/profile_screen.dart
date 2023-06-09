import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/services/firebase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

                             labelText: 'Name',
                             hintText: 'enter name',
                             prefixIcon: Icon(Icons.person),

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

                           labelText: 'Roll no.',
                           hintText: 'Enter Roll no.',
                           prefixIcon: Icon(Icons.money),

                           border: OutlineInputBorder()
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty||value.trim().length<=1 ||
                             value.trim().length>6) {
                           return 'Enter Valid Roll No.';
                         }
                         return null;
                       },
                     ),
                     SizedBox(
                       height: 20,
                     ),


                     SizedBox(height: 20,),

                     TextFormField(

                       onChanged: (value3){
                         desc = value3;
                       },

                       decoration: InputDecoration(

                           labelText: 'Mobile no.',
                           hintText: 'enter mobile no.',
                           prefixIcon: Icon(Icons.description),

                           border: OutlineInputBorder()
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
                     child: Text("Update Profile"),)
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
      'ProductColor': desc,
      'Category': dropdownValue,
      'image': imgUrl,
    };
      OurShop.add(data);

 });

}
}