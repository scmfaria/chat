import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    
    final pickedImage = await picker.getImage(
      source: ImageSource.camera
    );

    setState(() {
      _pickedFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedFile != null ? FileImage(_pickedFile) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage, 
          icon: Icon(
            Icons.image, 
            color: Theme.of(context).primaryColor
          ),
          label: Text(
            'Adicionar Imagem', 
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}