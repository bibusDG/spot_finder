import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spot_finder/my_widgets.dart';
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
          title: Text('PHOTO PAGE'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, child: Image.asset('assets/icons/32-videocam-outline.gif')),
              SizedBox(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Photo',
                      content: GetX<PhotoController>(
                        builder: (controller) {
                          return Column(
                            children: [
                              Text('${controller.photoCounter.value} photo left'),
                              CupertinoButton(
                                child: Text('Take a photo'),
                                onPressed: () {
                                  Get.back();
                                  controller.imageFromCamera();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.black,
                    // side: BorderSide(color: Colors.teal, width: 5.0),
                  ),
                  child: Obx(() => Text(
                        photoController.buttonText.value,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      )),
                ),
              ),
              GetX<ModelController>(builder: (controller) {
                if (controller.spotPhotosText.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: MyNextOutlinedButton(
                      onPressedValid: false,
                      goTo: 'gpsPage',
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: MyNextOutlinedButton(
                      onPressedValid: true,
                      goTo: 'gpsPage',
                    ),
                  );
                }
              }),
              MyCancelButton(),
            ],
          ),
        ),
      ),
    );
  }
}
