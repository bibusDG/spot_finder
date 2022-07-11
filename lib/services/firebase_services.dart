import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spot_finder/models/new_spot_model.dart';
import 'package:skate_spot_finder/storage.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';


class FirebaseServices {

  ModelController modelController = Get.put(ModelController());
  FindSpotController findSpotController = Get.put(FindSpotController());

  void initListener()async{
    fetchSpots();
    FirebaseFirestore.instance.collection('spots').snapshots().listen((spots){
      mapRecords(spots);
    });
  }

  //   initListener()async {
  //   fetchSpots();
  //   FirebaseFirestore.instance.collection('spots').doc('0').snapshots().listen((spots){
  //     var f = spots.get('spotRiders');
  //     print(f);
  //     return f;
  //   });
  // }


  void createSpot() async{
    await fetchSpots();
    final spot = modelController.createSpot();
    try{
      await FirebaseFirestore.instance.collection('spots').doc(findSpotController.spotList.length.toString()).set(spot.toJson());
      await riderSwitch.write(findSpotController.spotList.length.toString(),false);
    }catch(e){
      print('Failed');
    }
    print('Success');
  }

  void updateSpot(elementToUpdate, valueToUpdate) async{
    try{
      await FirebaseFirestore.instance.collection('spots').doc(elementToUpdate.toString()).update(valueToUpdate);
    }catch(e){
      print('Failed');
    }
    print('Success');
  }


    fetchSpots()async{
      var spots = await FirebaseFirestore.instance.collection('spots').get();
      await mapRecords(spots);
    }


    mapRecords(QuerySnapshot<Map<String, dynamic>> spots){
      var spotList = spots.docs.map(
          (item)=> NewSpotModel(
            spotName: item['spotName'],
            spotDescription: item['spotDescription'],
            spotProperties: item['spotProperties'],
            spotAddress: Address.fromJson(item['spotAddress']),
            spotRiders: item['spotRiders'],
            spotRank: item['spotRank'],
            votesCounter: item['votesCounter'],
            spotPhotos: item['spotPhotos'],
          ),
      ).toList();
      findSpotController.spotList.value = spotList;
    }

  setSwitch()async{
    var spots = await FirebaseFirestore.instance.collection('spots').get();
    await mapSwitch(spots);
  }


  mapSwitch(QuerySnapshot<Map<String, dynamic>> spots){
    var spotList = spots.docs.map(
          (item)=> NewSpotModel(
        spotName: item['spotName'],
        spotDescription: item['spotDescription'],
        spotProperties: item['spotProperties'],
        spotAddress: Address.fromJson(item['spotAddress']),
        spotRiders: item['spotRiders'],
        spotRank: item['spotRank'],
        votesCounter: item['votesCounter'],
        spotPhotos: item['spotPhotos'],
      ),
    ).toList();
    if (spotList.isNotEmpty){
      for(var i=0; i<spotList.length;i++){
        riderSwitch.write(i.toString(), false);
      }
    }else{}

  }

}