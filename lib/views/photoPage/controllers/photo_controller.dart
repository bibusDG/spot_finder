import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io'as Io;

import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';



class PhotoController extends GetxController{

  ModelController modelController = Get.find();

  RxInt photoCounter = 3.obs;
  List photoList = [];
  RxString buttonText = 'TAKE A PHOTO'.obs;

  Future imageFromCamera() async {
    if(photoList.length < 3){
      try{
        final image = await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
        if (image == null) return;
        final finalImage = Io.File(image.path);

        final bytes = finalImage.readAsBytesSync();
        String img64 = base64Encode(bytes);
        photoList.add(img64);
        modelController.spotPhotosText.value = photoList;
        photoCounter.value--;
        print(photoList.length);
        print(modelController.spotPhotosText.length);
        buttonText.value = 'TAKE ANOTHER PHOTO';

      }catch(error){
        print('error');
      }
    }else{
      // Get.back();
      Get.defaultDialog(
        title: 'Photo',
        content: Text('You have already 3 photos'),
      );
    }

  }

}