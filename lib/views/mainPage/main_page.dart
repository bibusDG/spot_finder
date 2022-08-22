import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';


//TODO clean code by extracting widgets

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: Text('SKATE SPOT'),
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 160, width: 160, child: Lottie.asset('assets/icons/1808-skateboarding-outline.json'),),
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
                      // content: CircularProgressIndicator(color: Colors.black,),
                      content: SizedBox(height:160, width:160, child: Lottie.asset('assets/icons/69-eye-outline.json')),
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
            Center(
              child: SizedBox(
                width: 250.0,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Dear skaters...',
                      content: Column(
                        children: [
                          Text('This app is made by skater for skaters.\n'
                              'By using this app, You can add, find, rate and\n'
                              'check amount of riders on spot\n\n'
                              'Additional info:\n'
                              '* It is not necessary to login,\n'
                              '* I will not collect any personal data,\n'
                              '* Please take care, that all info provided by\n'
                              'You about skate spot, are valid and true, as\n'
                              'all of us want to ride on verified places.\n'
                              '* Take care about good photos from camera (max 3),\n'
                              '* Insert real localization (using GPS),\n'
                              'so any of us can find spot easily and fast.\n'
                              '* To save/create a new spot, it is necessary to add min. 1 photo\n'
                              'and GPS localization. Please take care, that app has access\n'
                              'to camera and GPS.\n'
                              '* If You have left a spot or want to close app, please take '
                              'care to uncheck switch, so we will have actual number of\n'
                              'riders on spot.\n\n'
                              'Responsibility:\n'
                              'I will not take any responsibility if photos, text\n'
                              'or comments inserted in this app will be inappropriate\n'
                              'or will abuse anyone (hope nothing like this will happen).\n'
                              'Remember - You are creating this app and its content.\n\n'
                              'Thanks to:\n'
                              'Thanks to Lordicon.com we can enjoy great animated icons used in this app\n'
                              'Please visit: https://lordicon.com/\n\n'
                              'Enjoy the app: bibus - the creator'
                          )
                        ],
                      )
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: StadiumBorder(),
                    // side: BorderSide(color: Colors.black, width: 10.0),
                  ),
                  child: Text(
                    'ABOUT APP',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
