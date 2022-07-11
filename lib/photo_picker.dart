import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io'as Io;

class ImagesFromCamera {

  Future imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final finalImage = image.toString();

    // InitDataBase.instance.update({
    //   InitDataBase.spotID: findPageController.spotIndex.value+1,
    //   InitDataBase.spotImages: finalImage,
    // });
  }

  Future imageFromCamera() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      if (image == null) return;
      final finalImage = Io.File(image.path);


      final bytes = finalImage.readAsBytesSync();
      String img64 = base64Encode(bytes);

      // newSpotController.photoCounter.value--;
      // print(newSpotController.spotImages.length);


      // InitDataBase.instance.update({
      //   InitDataBase.spotID: findPageController.spotIndex.value+1,
      //   InitDataBase.spotImages: newSpotController.spotImages.join(', '),
      // });
    }catch(error){
      print('error');
    }
  }
}
