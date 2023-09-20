import 'package:elancer_api/api/controllers/image_api_controller.dart';
import 'package:elancer_api/models/student_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImagesGetxController extends GetxController {

  RxList<StudentImage> studentImages = <StudentImage>[].obs;
  final ImagesApiController _imagesApiController = ImagesApiController();

  static ImagesGetxController  get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  Future<void> read(BuildContext context) async {
    studentImages.value = await _imagesApiController.images(context);
  }

  Future<void> uploadImage({
    required BuildContext context,
    required String path,
    required UploadImageCallback uploadImageCallback
  })async {
   await _imagesApiController.uploadImage(
      context, path: path, uploadImageCallback: (
        {required String message,required bool statues, studentImage}) {
          if(statues) studentImages.add(studentImage!);
          uploadImageCallback(statues: statues ,  message: message , studentImage: studentImage);

      },
    );
  }

  Future<bool> deleteImage(BuildContext context ,{required int id})async{
    bool deleted =  await _imagesApiController.deleteImage(context, id: id);
    if(deleted){
      int index = studentImages.indexWhere((element) => element.id == id);
      if(index != -1){
        studentImages.removeAt(index);
      }
    }
    return deleted ;
  }

}