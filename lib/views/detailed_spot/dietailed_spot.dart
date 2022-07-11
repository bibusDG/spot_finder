import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:skate_spot_finder/services/firebase_services.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedSpot extends StatelessWidget {
  const DetailedSpot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // FindSpotController findSpotController = Get.put(FindSpotController());

    // DetailedPageController detailedPageController = Get.put(DetailedPageController());
    DetailedPageController detailedPageController = Get.find();
    ModelController modelController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            SizedBox(width: 10.0,),
            GestureDetector(onTap:(){Get.toNamed('/mainPage');Get.deleteAll();},child: Icon(Icons.home_outlined, size: 35.0,),),
            SizedBox(width: 10.0,),
            GestureDetector(onTap:(){
              Get.defaultDialog(title: 'Laoding...', content: CircularProgressIndicator());
              Future.delayed(2.seconds,(){
                Get.back();
                Get.toNamed('/findSpot');});},
              child: Icon(Icons.format_list_numbered, size: 35.0,),),


          ],
        ),
        centerTitle: true,
        title: Text('Spot details'),),
      body: GetX<FindSpotController>(builder: (controller){
        return Column(
          children: [
            Expanded(flex:3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageView(
                  controller: PageController(
                    viewportFraction: 0.6,
                  ),
                  children: [
                    for( var image in controller.spotList[detailedPageController.spotIndex].spotPhotos!)
                      image != '' ? Image.memory(base64Decode(image)) : Center(child: Icon(size:70.0, Icons.no_photography_outlined)),


                  ],),
              ),
            ),
            Expanded(flex:2,child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0,),
                  Text('SPOT NAME: ', style: TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, bottom: 20.0),
                    child: Text('${controller.spotList[detailedPageController.spotIndex].spotName}',),
                  ),
                  Text('FULL ADDRESS: ', style: TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, bottom: 20.0),
                    child: Text('${controller.spotList[detailedPageController.spotIndex].spotAddress!.countryName}, '
                    '${controller.spotList[detailedPageController.spotIndex].spotAddress!.postalCode} '
                    '${controller.spotList[detailedPageController.spotIndex].spotAddress!.cityName}, '
                    '${controller.spotList[detailedPageController.spotIndex].spotAddress!.streetName} '
                    '${controller.spotList[detailedPageController.spotIndex].spotAddress!.streetNumber}, '),
                  ),
                  Text('SPOT PROPERTIES: ', style: TextStyle(fontSize: 20.0),),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text('${controller.spotList[detailedPageController.spotIndex].spotProperties?.join(', ')}'),
                  ),

                  // Text('Country: ${controller.spotList[detailedPageController.spotIndex].spotAddress!.countryName}', style: TextStyle(fontSize: 20.0),),
                  // Text('Postal code: ${controller.spotList[detailedPageController.spotIndex].spotAddress!.postalCode}', style: TextStyle(fontSize: 20.0),),
                  // Text('City: ${controller.spotList[detailedPageController.spotIndex].spotAddress!.cityName}', style: TextStyle(fontSize: 20.0),),
                  // Text('Street name: ${controller.spotList[detailedPageController.spotIndex].spotAddress!.streetName}', style: TextStyle(fontSize: 20.0),),
                  // Text('Street number: ${controller.spotList[detailedPageController.spotIndex].spotAddress!.streetNumber}', style: TextStyle(fontSize: 20.0),),
                  // Text('Spot properties: ${controller.spotList[detailedPageController.spotIndex].spotProperties?.join(', ')}', style: TextStyle(fontSize: 20.0),),
                  SizedBox(height: 25.0,),

                  // Text('Spot name: ${controller.spotList[detailedPageController.spotIndex].spotAddress!.streetName}', style: TextStyle(fontSize: 20.0),),


                ],
              ),
            ),),
            Expanded(flex:1,
              child: Column(
                children: [
                  ElevatedButton(onPressed: () async{
                    if (!await launchUrl(Uri.parse('https://www.google.pl/maps/search/${controller.spotList[detailedPageController.spotIndex].spotAddress!.toJson().values.join(', ')}/'))) throw 'Could not launch';
                  }, child: Text('Find spot on map')),
                  ElevatedButton(onPressed: (){
                    Get.defaultDialog(
                      title: 'Rate spot',
                      content: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_outlined,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                            modelController.spotRankText.value = rating;
                          // print(rating);
                        },
                      ),
                      onConfirm: ()
                      async{
                        var newSpotRank = controller.spotList[detailedPageController.spotIndex].spotRank?.toDouble();
                        var spotVotes = controller.spotList[detailedPageController.spotIndex].votesCounter?.toInt();
                        // print(spotVotes);
                        // print(newSpotRank);
                        FirebaseServices().updateSpot(detailedPageController.spotIndex, {'spotRank': newSpotRank! + modelController.spotRankText.value});
                        FirebaseServices().updateSpot(detailedPageController.spotIndex, {'votesCounter': spotVotes! + 1});
                        Get.back();
                        await Get.toNamed('/findSpot');
                      },
                    );
                  }, child: Text('Give rating')),
                ],
              ),
            ),
          ],

        );
      })
    );
  }
}

