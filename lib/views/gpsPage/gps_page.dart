import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:skate_spot_finder/services/firebase_services.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';

import '../../geolocation.dart';

class GpsPage extends StatelessWidget {
  const GpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ModelController modelController = Get.put(ModelController());
    ModelController modelController = Get.find();
    GeoLocation geoLocation = GeoLocation();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(''),
          centerTitle: true,
          title: Text('GPS PAGE'),),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Choose option',
                      content:Column(children: [
                        CupertinoButton(child: Text('Insert manually'), onPressed: (){
                          Get.back();
                          Get.toNamed('/manualGPS',);

                        }),
                        CupertinoButton(child: Text('From GPS'), onPressed: ()async{
                          geoLocation.determinePosition;
                          geoLocation.finalPosition();
                        }),
                      ],),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.teal, width: 5.0),
                  ),
                  child: Text(
                    'INSERT LOCATION',
                    style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                  ),
                ),
              ),
              // ElevatedButton(onPressed: (){
              //   Get.defaultDialog(
              //     title: 'Choose option',
              //     content:Column(children: [
              //       CupertinoButton(child: Text('Insert manually'), onPressed: (){
              //         Get.back();
              //         Get.toNamed('/manualGPS',);
              //
              //       }),
              //       CupertinoButton(child: Text('From GPS'), onPressed: ()async{
              //         geoLocation.determinePosition;
              //         geoLocation.finalPosition();
              //       }),
              //     ],),
              //   );
              // }, child: Text('Insert spot localization')),
              GetX<ModelController>(builder: (controller){
                if(controller.countryText.value == '' || controller.cityText.value =='' || controller.postalCodeText.value == '' || controller.streetNameText.value == ''){
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
                    padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
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
              // ElevatedButton(onPressed: (){
              //   Get.toNamed('/mainPage');
              //   Get.deleteAll();},
              //     child: Text('Cancel'))
              // ElevatedButton(onPressed: (){Get.toNamed('/mainPage'); modelController.}, child: Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }
}

// ElevatedButton(onPressed: (){
// FirebaseServices().createSpot();
// Future.delayed(Duration(seconds: 2),(){Get.toNamed('/findSpot');});
// }, child: Text('Save spot'));