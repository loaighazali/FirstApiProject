import 'package:elancer_api/api/api_setting.dart';
import 'package:elancer_api/get/images_getx_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final ImagesGetxController _imagesGetxController =
      Get.put(ImagesGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.cyan,
        title: const Text(
          'Images',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/upload_image_screen');
            },
            icon: const Icon(Icons.cloud_upload),
          ),
        ],
        centerTitle: true,
      ),
      body: GetX<ImagesGetxController>(
        builder: (controller) {
          if (controller.studentImages.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsetsDirectional.all(20),
              itemCount: controller.studentImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.network(
                          ApiSetting.getImageUrl(
                              controller.studentImages[index].image),
                          fit: BoxFit.cover),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10),
                          height: 40,
                          color: Colors.white70,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.studentImages[index].image,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () async =>
                                    await ImagesGetxController.to.deleteImage(
                                        context,
                                        id: controller.studentImages[index].id),
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    size: 85,
                    color: Colors.grey,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
