import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   //const ProfileScreen({Key? key}): super(key: key);
   String? profilePic;
   String name = "",col ="",price="";
   String dropdownValue = 'Books';
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
                        // onChanged: (value){
                            //name = value;},
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
                       // onChanged: (value1){
                       //   price = value1;
                       //
                       // },
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
                         col = value3;
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
  }}

saveInfo() {
}