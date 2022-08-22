import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:skate_spot_finder/my_widgets.dart';
import 'package:skate_spot_finder/services/firebase_services.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';

import '../../geolocation.dart';

class GpsPage extends StatelessWidget {
  const GpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Container(height: 100,width: 100,child: Image.asset('assets/icons/18-location-pin-lineal.gif'),),
              SizedBox(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {
                    geoLocation.determinePosition;
                    geoLocation.finalPosition();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.black
                    // side: BorderSide(color: Colors.teal, width: 5.0),
                  ),
                  child: Text(
                    'INSERT LOCATION',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
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
                          backgroundColor: Colors.black
                          // side: BorderSide(color: Colors.teal, width: 5.0),
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
                          Get.defaultDialog(title: 'Loading...', 
                              content: SizedBox(height:100, width:100, child: Lottie.asset('assets/icons/18-location-pin-outline.json')));
                          Future.delayed(Duration(seconds: 3),(){
                            Get.back();
                            Get.toNamed('/findSpot');});
                        },
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.black
                          // side: BorderSide(color: Colors.teal, width: 5.0),
                        ),
                        child: Text(
                          'SAVE SPOT',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
              }),
              SizedBox(
                height: 60.0,
                width: 250.0,
                child: MyCancelButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
