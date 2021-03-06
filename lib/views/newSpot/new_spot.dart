import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import 'package:skate_spot_finder/views/photoPage/controllers/photo_controller.dart';

List spotData = [
  'rails',
  'stairs',
  'gaps',
  'flat',
  'concrete',
  'grinds',
  'banks',
  'wood',
  'asphalt',
  'street',
  'skatepark'
];

class NewSpot extends StatelessWidget {
  const NewSpot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ModelController modelController = Get.put(ModelController());
    ModelController modelController = Get.put(ModelController());
    PhotoController photoController = Get.put(PhotoController());
    DetailedPageController detailedPageController = Get.put(DetailedPageController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 120,
          leading: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/mainPage');
                  Get.deleteAll();
                },
                child: Icon(
                  Icons.home_outlined,
                  size: 35.0,
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: Text('CREATE NEW SPOT'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                    width: 400,
                    child: TextFormField(
                      onChanged: (String value) {
                        modelController.spotNameText.value = value;
                      },
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.teal, width: 4.0),),
                          hintText: 'Spot name',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 0),
                  child: SizedBox(
                    width: 400,
                    child: TextFormField(
                      onChanged: (String value) {
                        modelController.spotDescriptionText.value = value;
                      },
                      minLines: 3,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.teal, width: 4.0),),
                          hintText: 'Spot description',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 0),
                  child: SizedBox(
                    width: 400,
                    child: MultiSelectDialogField(
                      title: Text(''),
                      buttonText: Text('Choose spot details', style: TextStyle(color: Colors.grey),),
                      items: spotData.map((e) => MultiSelectItem(e, e)).toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        modelController.spotPropertiesText.value = values;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                GetX<ModelController>(builder: (controller) {
                  if (controller.spotNameText.value == '' ||
                      controller.spotDescriptionText.value == '' ||
                      controller.spotPropertiesText.isEmpty) {
                    return SizedBox(
                      height: 60.0,
                      width: 200.0,
                      child: OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.teal, width: 5.0),
                        ),
                        child: Text(
                          'NEXT',
                          style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 60.0,
                      width: 200.0,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed('/photoPage');
                        },
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.teal, width: 5.0),
                        ),
                        child: Text(
                          'NEXT',
                          style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                        ),
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 60.0,
                  width: 200.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/mainPage');
                      Get.deleteAll();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(color: Colors.teal, width: 5.0),
                    ),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void onPressedState(){
//   if (modelController.spotNameText != '' && modelController.spotDescriptionText !='' && modelController.spotPropertiesText !=[]){
//     return
//   }
// }

// ElevatedButton(onPressed: (){Get.toNamed('/mainPage'); Get.deleteAll();}, child: Text('Cancel')),
// CupertinoButton(child: Text('Take Photo'), onPressed: (){
//   Get.defaultDialog(
//     title: 'Photo',
//     content: GetX<PhotoController>(builder: (controller){
//       return Column(
//         children: [
//           Text('${controller.photoCounter} photo left'),
//           CupertinoButton(child: Text('Take a photo'), onPressed: (){
//             controller.imageFromCamera();
//           },),
//         ],
//       );
//     },
//
//     ),
//   );
// }),
// CupertinoButton(child: Text('Insert spot address'),
//     onPressed: (){
//   Get.defaultDialog(
//     title: 'Choose option',
//     content:Column(children: [
//       CupertinoButton(child: Text('Insert manually'), onPressed: (){
//         Get.back();
//         Get.toNamed('/manualGPS',);
//
//       }),
//       CupertinoButton(child: Text('From GPS'), onPressed: (){}),
//     ],),
//   );
//     }),
// CupertinoButton(child: Text('Save spot'), onPressed: (){})