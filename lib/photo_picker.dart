import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io'as Io;

class ImagesFromCamera {

  Future imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final finalImage = image.toString();
  }

  Future imageFromCamera() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      if (image == null) return;
      final finalImage = Io.File(image.path);
      final bytes = finalImage.readAsBytesSync();
      String img64 = base64Encode(bytes);

    }catch(error){
      print('error');
    }
  }
}
