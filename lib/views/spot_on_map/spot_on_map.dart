import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../my_widgets.dart';
import '../findSpot/controllers/findSpot_controller.dart';

class SpotOnMap extends StatelessWidget {
  const SpotOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    WebViewController _controller;


    DetailedPageController detailedPageController = Get.find();
    FindSpotController findSpotController = Get.find();

    var gpsLoc = [detailedPageController.data['spotAddress']['latitude'],
        detailedPageController.data['spotAddress']['longitude']].join(',+');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 180,
          leading: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              MyHomeIcon(),
              SizedBox(width: 20.0,),
              GestureDetector(onTap: () {
                Get.defaultDialog(
                  title: 'Loading...',
                  // content: CircularProgressIndicator(color: Colors.black,),
                  content: SizedBox(height:160, width:160, child: Lottie.asset('assets/icons/69-eye-outline.json')),
                );
                Future.delayed(Duration(seconds: 3), () {
                  Get.back();
                });
                Future.delayed(Duration(seconds: 3), () {
                  Get.toNamed('/findSpot');
                });
                // FirebaseServices().initListener();
              }, child: Icon(Icons.format_list_numbered, size: 30.0)),
              SizedBox(width: 20.0,),
              GestureDetector(onTap:(){
                Get.back();
              },child: Icon(Icons.arrow_back)),


            ],
          ),
          centerTitle: true,
          title: Text(detailedPageController.data['spotName'] + ' ON MAP'),


        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController c){
            _controller = c;
            _controller.loadUrl('https://www.google.com/maps/search/$gpsLoc');
          },
        ),
      ),
    );
  }
}
