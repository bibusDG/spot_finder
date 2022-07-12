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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        height: 60.0,
                        width: 250.0,
                        child: OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(color: Colors.teal, width: 5.0),
                          ),
                          child: Text(
                            'SAVE SPOT',
                            style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                          ),
                        ),
                      ),
                    );
                  }else{
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        height: 60.0,
                        width: 250.0,
                        child: OutlinedButton(
                          onPressed: (){
                            FirebaseServices().createSpot();
                            Get.defaultDialog(title: 'Loading...', content: CircularProgressIndicator());
                            Future.delayed(Duration(seconds: 2),(){
                              Get.back();
                              Get.toNamed('/findSpot');});
                          },
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(color: Colors.teal, width: 5.0),
                          ),
                          child: Text(
                            'SAVE SPOT',
                            style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                          ),
                        ),
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: 60.0,
                  width: 250.0,
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
                // ElevatedButton(child: Text('Cancel'), onPressed: (){
                //   // modelController.newSpot.spotAddress = modelController.address;
                //   // print(modelController.newSpot.toJson());
                //   // print(modelController.address.toJson());
                //   // FirebaseServices().fetchSpots();
                //   // findSpotController.createSpot();
                //   // clearSpotData();
                //   Get.toNamed('/mainPage');
                //   Get.deleteAll();
                //
                //
                //
                //   // FirebaseServices().read();
                //   // findSpotController.fetchProducts();
                //
                //
                // }),
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




