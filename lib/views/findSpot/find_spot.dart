import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:skate_spot_finder/storage.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';

import '../../services/firebase_services.dart';

class FindSpot extends StatelessWidget {
  const FindSpot({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    

    FindSpotController findSpotController = Get.put(FindSpotController());
    DetailedPageController detailedPageController = Get.put(DetailedPageController());
    // FirebaseServices().fetchSpots();
    FirebaseServices().initListener();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 120,
          leading: Row(
            children: [
              SizedBox(width: 10.0,),
              GestureDetector(onTap:(){Get.toNamed('/mainPage');Get.deleteAll();},child: Icon(Icons.home_outlined, size: 35.0,),),


            ],
          ),
          centerTitle: true,
          title: Text('SPOTS LIST'),),
        body: GetX<FindSpotController>(builder: (controller){
          return ListView.builder(
              itemCount: controller.spotList.length,
              itemBuilder: (context, index){
                // riderSwitch.write(index.toString(), false);
                // print(riderSwitch.read(index.toString()));
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(height: 200, child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (){
                        detailedPageController.spotIndex = index;
                        Get.toNamed('/detailPage');
                      },
                      child: Row(
                        children: [
                          Expanded(flex:1, child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (controller.spotList[index].spotPhotos?.length !=null)...[
                                SizedBox(height: 10.0,),
                                SizedBox(height: 130, child: Image.memory(base64Decode(controller.spotList[index].spotPhotos![0]))),
                                RatingBarIndicator(
                                  rating: ratingSpotStars(controller, index),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),

                              ]else...[
                                SizedBox(height: 10.0,),
                                SizedBox(height: 130, child: Icon(Icons.no_photography_outlined, size: 80,)),

                              ]



                            ],
                          ),),
                          Expanded(flex:2, child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.list_outlined, size: 30.0,),
                                    SizedBox(width: 10,),
                                    Text(controller.spotList[index].spotName.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.emoji_flags_outlined, size: 30),
                                    SizedBox(width: 10,),
                                    Text(controller.spotList[index].spotAddress!.countryName.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_city, size: 30,),
                                    SizedBox(width: 10,),
                                    Text(controller.spotList[index].spotAddress!.cityName.toString()),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Icon(Icons.edit_road, size:30.0,),
                                //     SizedBox(width: 10,),
                                //     Text(controller.spotList[index].spotAddress!.streetName.toString()),
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 30.0,),
                                    Text(controller.spotList[index].spotRiders.toString()),
                                    SizedBox(width: 50.0,),
                                    Text('I\'M RIDING'),
                                    ValueBuilder<bool?>(
                                      initialValue: riderSwitch.read(index.toString()) ?? false,
                                      builder: (value, updateFn){
                                        return Switch(
                                          value: value!,
                                          onChanged: updateFn,
                                          // same signature! you could use ( newValue ) => updateFn( newValue )
                                        );
                                      },
                                      // if you need to call something outside the builder method.
                                      onUpdate: (value) async{
                                        print("Value updated: $value");
                                        await riderSwitch.write(index.toString(), value);
                                        if(controller.spotList[index].spotRiders!>=0 && value==true){
                                          FirebaseServices().updateSpot(index, {'spotRiders': controller.spotList[index].spotRiders!+1});
                                        }
                                        if(controller.spotList[index].spotRiders!>0 && value==false){
                                          FirebaseServices().updateSpot(index, {'spotRiders': controller.spotList[index].spotRiders!-1});
                                        }
                                      },
                                      onDispose: (){
                                        // if(controller.spotList[index].spotRiders!>0){
                                        //   FirebaseServices().updateSpot(index, {'spotRiders': controller.spotList[index].spotRiders!-1});
                                        // }
                                          print("Widget unmounted");
                                        }
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),),
                );
              }
          );
        }

        ),
      ),
    );
    }
    ratingSpotStars(controller, index){
    double stars;
      if (controller.spotList[index].votesCounter?.toInt() <=0){
        stars = 0.0;
      }else{
        stars = controller.spotList[index].spotRank?.toDouble()/controller.spotList[index].votesCounter?.toInt();
      }
      return stars;
    }


    
}
