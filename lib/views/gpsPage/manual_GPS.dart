import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skate_spot_finder/models/new_spot_model.dart';
import 'package:skate_spot_finder/services/firebase_services.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import 'package:skate_spot_finder/views/photoPage/controllers/photo_controller.dart';

import '../../my_widgets.dart';

class ManualGPS extends StatelessWidget {
  const ManualGPS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ModelController modelController = Get.find();
    // FindSpotController findSpotController = Get.find();
    // var dd = modelController.address;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Text(''),
            centerTitle: true,
              title: Text('Manual Localization')),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top:0),
                  child: SizedBox(width:400,
                    child: Column(
                      children: [
                        GetX<ModelController>(builder: (controller){return MyWidget(modelController: modelController, helperText: 'Country',finalText: controller.countryText.value);}),
                        GetX<ModelController>(builder: (controller){return MyWidget(modelController: modelController, helperText: 'City',finalText: controller.cityText.value);}),
                        GetX<ModelController>(builder: (controller){return MyWidget(modelController: modelController, helperText: 'Postal code',finalText: controller.postalCodeText.value);}),
                        GetX<ModelController>(builder: (controller){return MyWidget(modelController: modelController, helperText: 'Street name',finalText: controller.streetNameText.value);}),
                        GetX<ModelController>(builder: (controller){return MyWidget(modelController: modelController, helperText: 'Street number',finalText: controller.streetNumberText.value);}),
                      ],
                    ),),
                ),
                GetX<ModelController>(builder: (controller){
                  if(controller.countryText.value == '' || controller.cityText.value =='' || controller.postalCodeText.value == '' || controller.streetNameText.value == ''){
                    return ElevatedButton(onPressed: null, child: Text('Save spot'));
                  }else{
                    return ElevatedButton(onPressed: (){
                      FirebaseServices().createSpot();
                      Get.toNamed('/findSpot');
                    }, child: Text('Save spot'));
                  }
                }),
                ElevatedButton(child: Text('Cancel'), onPressed: (){
                  // modelController.newSpot.spotAddress = modelController.address;
                  // print(modelController.newSpot.toJson());
                  // print(modelController.address.toJson());
                  // FirebaseServices().fetchSpots();
                  // findSpotController.createSpot();
                  // clearSpotData();
                  Get.toNamed('/mainPage');
                  Get.deleteAll();



                  // FirebaseServices().read();
                  // findSpotController.fetchProducts();


                }),
              ],
            ),

          ),
        ));
  }

  // void clearSpotData(){
  //   modelController.insertedValue = '';
  //   modelController.countryText.value = '';
  //   modelController.cityText.value ='';
  //   modelController.postalCodeText.value='';
  //   modelController.streetNameText.value ='';
  //   modelController.streetNumberText.value='';
  //
  // }
}




