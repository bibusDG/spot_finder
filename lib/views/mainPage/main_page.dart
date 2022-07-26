import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skate_spot_finder/storage.dart';
import '../../services/firebase_services.dart';
import '../detailed_spot/controllers/detailed_spot_controller.dart';
import '../findSpot/controllers/findSpot_controller.dart';

//TODO clean code by extracting widgets

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: Text('SKATE SPOT CREATOR'),
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 100, width: 100, child: Image.asset('assets/icons/62-butt-outline.gif'),),
            Center(
              child: SizedBox(
                width: 250.0,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/newSpot');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: StadiumBorder(),
                    // side: BorderSide(color: Color(0xffec3e4b), width: 10.0),
                  ),
                  child: Text(
                    'CREATE NEW SPOT',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: SizedBox(
                width: 250.0,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Loading...',
                      content: CircularProgressIndicator(color: Colors.black,),
                    );
                    Future.delayed(Duration(seconds: 3), () {
                      Get.back();
                    });
                    Future.delayed(Duration(seconds: 3), () {
                      Get.toNamed('/findSpot');
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: StadiumBorder(),
                    // side: BorderSide(color: Colors.black, width: 10.0),
                  ),
                  child: Text(
                    'FIND SPOT',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Center(
            //   child: SizedBox(
            //     width: 250.0,
            //     height: 100,
            //     child: OutlinedButton(
            //       onPressed: () {
            //         Future.delayed(Duration(seconds: 1), () {
            //           Get.toNamed('/startPage');
            //         });
            //       },
            //       style: OutlinedButton.styleFrom(
            //         shape: StadiumBorder(),
            //         side: BorderSide(color: Color(0xffec3e4b), width: 10.0),
            //       ),
            //       child: Text(
            //         'Choose sport',
            //         style: TextStyle(fontSize: 20.0, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            // CupertinoButton(child: Text('Create new spot'),
            //     onPressed: (){
            //     Get.toNamed('/newSpot');
            //     }),
            // CupertinoButton(child: Text('Find spot'),
            //     onPressed: (){
            //       Get.defaultDialog(
            //         title: 'Loading...',
            //         content: CircularProgressIndicator(),
            //       );
            //       Future.delayed(Duration(seconds: 1),(){Get.back();});
            //       Future.delayed(Duration(seconds: 1),(){Get.toNamed('/findSpot');});
            //
            //     }),
          ],
        ),
      ),
    );
  }
}
