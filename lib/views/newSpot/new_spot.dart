import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:skate_spot_finder/my_widgets.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import 'package:skate_spot_finder/views/photoPage/controllers/photo_controller.dart';

List spotData = [
  'RAILS',
  'STAIRS',
  'GAPS',
  'FLAT',
  'CONCRETE',
  'GRINDS',
  'BANKS',
  'WOOD',
  'ASPHALT',
  'STREET',
  'SKATEPARK'
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
                    child: MyTextFieldWidget(
                      modelController: modelController,
                      helperText: 'Spot name',)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 0),
                  child: SizedBox(
                    width: 400,
                    child: MyTextFieldWidget(
                        modelController: modelController,
                        helperText: 'Spot description')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 0),
                  child: SizedBox(
                    width: 390,
                    child: MultiSelectDialogField(
                      selectedColor: Colors.black45,
                      title: Text(''),
                      buttonText: Text('Choose spot details', style: TextStyle(color: Colors.black, fontSize: 18.0),),
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
                    return MyNextOutlinedButton(onPressedValid: false, goTo: 'photoPage',);
                  } else {
                    return MyNextOutlinedButton(onPressedValid: true, goTo: 'photoPage');
                  }
                }),
                SizedBox(
                  height: 20.0,
                ),
                MyCancelButton(),
                SizedBox(height: 10.0,),
                // SizedBox(width:100, height:100, child: Image.asset('')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



