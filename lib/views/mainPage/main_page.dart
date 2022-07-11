import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skate_spot_finder/storage.dart';

import '../../services/firebase_services.dart';
import '../findSpot/controllers/findSpot_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: Text('Main Page'),
      ),
      body:SizedBox(
        child: Column(
          children: [
            CupertinoButton(child: Text('Create new spot'),
                onPressed: (){
                Get.toNamed('/newSpot');
                }),
            CupertinoButton(child: Text('Find spot'),
                onPressed: (){
                  Get.defaultDialog(
                    title: 'Loading...',
                    content: CircularProgressIndicator(),
                  );
                  Future.delayed(Duration(seconds: 1),(){Get.back();});
                  Future.delayed(Duration(seconds: 1),(){Get.toNamed('/findSpot');});

                }),
          ],
        ),
      ),
    );
  }

}
