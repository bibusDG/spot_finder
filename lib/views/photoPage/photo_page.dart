import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import 'controllers/photo_controller.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // PhotoController photoController = Get.put(PhotoController());
    PhotoController photoController = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(''),
          centerTitle: true,
          title: Text('Photo Page'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Get.defaultDialog(
                  title: 'Photo',
                  content: GetX<PhotoController>(builder: (controller){
                    return Column(
                      children: [
                        Text('${controller.photoCounter.value} photo left'),
                        CupertinoButton(
                          child: Text('Take a photo'),
                          onPressed: (){
                            Get.back();
                          controller.imageFromCamera();
                        },),
                      ],
                    );
                  },

                  ),
                );
              }, child: Obx(()=>Text(photoController.buttonText.value)),),
              GetX<ModelController>(builder: (controller){
                if(controller.spotPhotosText.isEmpty){
                  return ElevatedButton(onPressed: null, child: Text('Next'));
                }else{
                  return ElevatedButton(onPressed: (){
                    Get.toNamed('/gpsPage');
                  }, child: Text('Next'));
                }
              }),
              ElevatedButton(onPressed: (){Get.toNamed('/mianPage'); Get.deleteAll();}, child: Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }
}
