import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.cyan,
        title:const Text(
          'Images',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/upload_image_screen');
            },
            icon:const Icon(Icons.cloud_upload),
          ),
        ],
        centerTitle: true,
      ),

      body: GridView.builder(
        padding:const EdgeInsetsDirectional.all(20),
        itemCount: 10,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ), itemBuilder: (context, index) {
        return Card(
           elevation: 5,
          color: Colors.white,
        );
      },
      ),
    );
  }
}
