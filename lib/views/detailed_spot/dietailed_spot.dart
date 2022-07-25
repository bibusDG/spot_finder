import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:skate_spot_finder/my_widgets.dart';
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
    ModelController modelController = Get.put(ModelController());

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              MyHomeIcon(),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(title: 'Laoding...', content: CircularProgressIndicator());
                  Future.delayed(2.seconds, () {
                    Get.back();
                    Get.toNamed('/findSpot');
                  });
                },
                child: Icon(
                  Icons.format_list_numbered,
                  size: 35.0,
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: detailedPageController.data['spotName']!=null? Text('${detailedPageController.data['spotName'].toUpperCase()} DETAILS'): null

        ),
        body:Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PageView(
                      controller: PageController(
                        viewportFraction: 0.8,
                      ),
                      children: [
                        if(detailedPageController.data['spotPhotos'] != null)
                        for (var image in detailedPageController.data['spotPhotos'])
                          image != ''
                              ? Image.memory(base64Decode(image))
                              : Center(child: Icon(size: 70.0, Icons.no_photography_outlined)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          height: 60.0,
                          width: 250.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              return showModalBottomSheet(
                                backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MyDetailCard(
                                          detailedPageController: detailedPageController,
                                          cardText: 'ADDRESS',
                                        ),
                                        MyDetailCard(
                                          detailedPageController: detailedPageController,
                                          cardText: 'OBSTACLES',
                                        ),
                                      ],
                                    );
                                  });
                            },
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              side: BorderSide(color: Colors.teal, width: 5.0),
                            ),
                            child: Text(
                              'SPOT DETAILS',
                              style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          height: 60.0,
                          width: 250.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(
                                  'https://www.google.pl/maps/search/${detailedPageController.data['spotAddress'].values.join(', ')}/'))) {
                                throw 'Could not launch';
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              side: BorderSide(color: Colors.teal, width: 5.0),
                            ),
                            child: Text(
                              'FIND SPOT ON MAP',
                              style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                        width: 250.0,
                        child: OutlinedButton(
                          onPressed: () async {
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
                              onConfirm: () async {
                                var newSpotRank = detailedPageController.data['spotRank'].toDouble();
                                var spotVotes = detailedPageController.data['votesCounter'].toInt();
                                // print(spotVotes);
                                // print(newSpotRank);
                                FirebaseServices().updateSpot(detailedPageController.spotIndex,
                                    {'spotRank': newSpotRank! + modelController.spotRankText.value});
                                FirebaseServices()
                                    .updateSpot(detailedPageController.spotIndex, {'votesCounter': spotVotes! + 1});
                                Get.back();
                                await Get.toNamed('/findSpot');
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(color: Colors.teal, width: 5.0),
                          ),
                          child: Text(
                            'RATE SPOT',
                            style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
                          ),
                        ),
                      ),
                      //TODO make spot description more attractive for user
                    ],
                  ),
                ),
              ],
        ),

      );
  }
}
