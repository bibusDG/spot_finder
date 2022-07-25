import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skate_spot_finder/geolocation.dart';
import 'package:skate_spot_finder/storage.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';

import '../../my_widgets.dart';
import '../../services/firebase_services.dart';

bool switchMarker = true;

Map mapOfGoogleMarkers = {};

// List<Marker> _marker =[];

class FindSpot extends StatelessWidget {
  const FindSpot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FindSpotController findSpotController = Get.put(FindSpotController());
    DetailedPageController detailedPageController = Get.put(DetailedPageController());




    // FirebaseServices().fetchSpots();
    // FirebaseServices().initListener();


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [GestureDetector(onTap: ()async{
            await FirebaseServices().buildMapOfMarkers();
            Get.toNamed('/googleMap');
          },
              child: Icon(Icons.pin_drop)),
            SizedBox(width: 30.0,)],
          leadingWidth: 180,
          leading: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              MyHomeIcon(),
              SizedBox(width: 20.0,),
              GestureDetector(onTap: () {
                findSpotController.cityNameFinder.value = '';
                // FirebaseServices().initListener();
              }, child: Icon(Icons.format_list_numbered, size: 30.0)),
              SizedBox(width: 20.0,),
              GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      title: 'FIND YOUR CITY',
                      content: Column(
                        children: [
                          TextFormField(
                            onChanged: (String value) {
                              findSpotController.cityNameFinder.value = value;
                            },
                            minLines: 1,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.teal, width: 4.0),),
                                hintText: findSpotController.cityNameFinder.value, prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.search, size: 30.0)),


              // Icon(Icons.search, size: 30.0,),
            ],
          ),
          centerTitle: true,
          title: Text('LIST OF SPOTS'),

        ),
        body: Obx(() {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('spots')
                  .where('spotAddress.cityName', isGreaterThanOrEqualTo: findSpotController.cityNameFinder.value.toUpperCase())
                  .where('spotAddress.cityName', isLessThanOrEqualTo: '${findSpotController.cityNameFinder.value.toUpperCase()}z')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data();
                        // print(docs.length);
                        // riderSwitch.write(index.toString(), false);
                        // print(riderSwitch.read(index.toString()));
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            height: 200,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                                onPressed: () {
                                  detailedPageController.data = data;
                                  detailedPageController.listLength = docs.length;
                                  detailedPageController.spotIndex.value = int.parse(data['id']);
                                  Get.toNamed('/detailPage');
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (data['spotPhotos'] != null) ...[
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            SizedBox(
                                                height: 130,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover, image: Image
                                                          .memory(base64Decode(data['spotPhotos']![0]))
                                                          .image),
                                                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                )),
                                            RatingBarIndicator(
                                              rating: ratingSpotStars(data, index),
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              direction: Axis.horizontal,
                                            ),
                                          ] else
                                            ...[
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              SizedBox(
                                                  height: 130,
                                                  child: Icon(
                                                    Icons.no_photography_outlined,
                                                    size: 80,
                                                  )),
                                            ]
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.list_outlined,
                                                size: 30.0,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(data['spotName']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.emoji_flags_outlined, size: 30),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(data['spotAddress']['countryName']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_city,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(data['spotAddress']['cityName']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.person),
                                              SizedBox(
                                                width: 30.0,
                                              ),
                                              Text(data['spotRiders'].toString()),
                                              SizedBox(
                                                width: 50.0,
                                              ),
                                              Text('I\'M RIDING'),
                                              ValueBuilder<bool?>(
                                                initialValue: riderSwitch.read(index.toString()) ?? false,
                                                builder: (value, updateFn) {
                                                  return Switch(
                                                    value: value!,
                                                    onChanged: (newValue) => updateFn(switchMarker),
                                                    // same signature! you could use ( newValue ) => updateFn( newValue )
                                                  );
                                                },
                                                // if you need to call something outside the builder method.
                                                onUpdate: (value) async {
                                                  if (switchMarker == false && value == false &&
                                                      riderSwitch.read(data['id']) == false) {
                                                    riderSwitch.write(data['id'], false);
                                                    Get.defaultDialog(title: 'Seriously...?',
                                                        content: Text('You are riding somewhere else!!!'));
                                                  }
                                                  // print("Value updated: $value");
                                                  // print(switchMarker);
                                                  //
                                                  await riderSwitch.write(data['id'], value);
                                                  if (data['spotRiders'] >= 0 && value == true &&
                                                      switchMarker == true) {
                                                    FirebaseServices().updateSpot(
                                                        data['id'], {'spotRiders': data['spotRiders'] + 1});

                                                    switchMarker = false;
                                                  }
                                                  if (data['spotRiders'] > 0 && value == false &&
                                                      switchMarker == false) {
                                                    FirebaseServices().updateSpot(
                                                        data['id'], {'spotRiders': data['spotRiders'] - 1});

                                                    switchMarker = true;
                                                  }
                                                }, //TODO not possible to mark more, that one spot
                                                // onDispose: () {
                                                //
                                                //   // if(controller.spotList[index].spotRiders!>0 && riderSwitch.read(index.toString())==true){
                                                //   //   FirebaseServices().updateSpot(index, {'spotRiders': controller.spotList[index].spotRiders!-1});
                                                //   // }
                                                //   print("Widget unmounted");
                                                // }
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      });
                }
                return Center(child: CircularProgressIndicator());
              }
          );
        }),
      ),
    );
  }

  ratingSpotStars(data, index) {
    double stars;
    if (data['spotRank'] <= 0.0) {
      stars = 0.0;
    } else {
      stars = data['spotRank'] / data['votesCounter'];
    }
    return stars;
  }


  // buildMapOfMarkers(data) {
  //   FindSpotController findSpotController = Get.find();
  //   findSpotController.markers.add(
  //       Marker(
  //           markerId: MarkerId(data['spotName']),
  //           position: LatLng(double.parse(data['spotAddress']['latitude']), double.parse(data['spotAddress']['longitude'])),
  //           infoWindow: InfoWindow(title: data['spotName'], snippet: data['spotRiders'].toString())));
  //   print(findSpotController.markers.length);
  //   // mapOfGoogleMarkers[data['spotName']] = [data['spotAddress']['latitude'], data['spotAddress']['longitude'], data['spotRiders']];
  // }

  // showGlobalMap() {
  //   GoogleMap(
  //     initialCameraPosition: CameraPosition(
  //       target: LatLng(38.9647, 35.2233),
  //       zoom: 9.0,
  //     ),
  //     mapType: MapType.normal,
  //     markers: Set<Marker>.of(_marker),
  //     onMapCreated: (GoogleMapController controller) {
  //       _controller.complete(controller);
  //     },
  //   );
  // }
}