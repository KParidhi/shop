import 'package:flutter/material.dart';
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
  }
  @override
   Widget build(BuildContext context){
    Widget content = ElevatedButton(onPressed: (){
      _takePicture;
    },
      child: Icon(Icons.camera_alt),
    );
    if(_selectedImage!=null){
      content = GestureDetector(
        onTap:_takePicture,
        child: Image.file(_selectedImage!,));
    }
    return Container(
      height: 250,
      width:  double.infinity,
      alignment: Alignment.center,

    );

  }
}