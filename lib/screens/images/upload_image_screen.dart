import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedFile;
  double? _linearProgressValue = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: const Text(
            'Upload Image',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              color: Colors.lightBlue,
              backgroundColor: Colors.grey,
              minHeight: 7,
              value:_linearProgressValue ,
            ),
            Expanded(
              child: _pickedFile != null
                  ? Image.file(File(_pickedFile!.path))
                  : TextButton(
                      onPressed: () async => await _pickImage(),
                      style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text('Pick Image'),
                    ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.cyan,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.cloud_upload,
                color: Colors.white,
                size: 30,
              ),
              label: const Text('Upload',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ],
        ));
  }

  Future<void> _pickImage() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() {
        _pickedFile = xFile;
      });
    }
  }
}
