import 'package:flutter/material.dart';
import 'package:home/services/firebase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImageInput extends StatefulWidget{
  ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput>{
   File? _selectedImage;
   String? imgUrl="";
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      {
        _selectedImage = File(pickedImage.path);
      }
    });
    imgUrl=await FirebaseServices.getImage(pickedImage);
  }
  @override
   Widget build(BuildContext context){
    Widget content = TextButton.icon(
      icon:const Icon(Icons.camera_alt,color: Colors.orange,),
      label:const Text("Take Picture",
      style: TextStyle(
        color: Colors.orange
      ),),
      onPressed:
      _takePicture,
    );
    if(_selectedImage!=null){
      content = GestureDetector(
        onTap:_takePicture,
        child: Image.file(_selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,));
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,

    );


  }

}