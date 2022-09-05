import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spot_finder/models/new_spot_model.dart';
import 'package:skate_spot_finder/storage.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';
import "package:latlong2/latlong.dart" as latLng;


List<NewSpotModel> myList =[];

class FirebaseServices {

  ModelController modelController = Get.put(ModelController());
  FindSpotController findSpotController = Get.put(FindSpotController());

  createSpot() async{
    await spotCounterID();
    await fetchSpots();
    modelController.id = (findSpotController.spotCounterID).toString();
    final spot = modelController.createSpot();
    try{
      await FirebaseFirestore.instance.collection('spots').doc((findSpotController.spotCounterID).toString()).set(spot.toJson());
      await riderSwitch.write((findSpotController.spotCounterID).toString(), false);

    }catch(e){
      print('Failed');
    }
    print('Success');
  }

  updateSpot(elementToUpdate, valueToUpdate) async{
    try{
      await FirebaseFirestore.instance.collection('spots').doc(elementToUpdate.toString()).update(valueToUpdate);
    }catch(e){
      print('Failed');
    }
    print('Success');
  }


    fetchSpots()async{
      var spots = await FirebaseFirestore.instance.collection('spots').get();
      // print(spots);
      await mapRecords(spots);
    }

    deleteSpot(spotID)async{
      final _db_toDelete = FirebaseFirestore.instance;
      await _db_toDelete.collection('spots').doc(spotID).delete();
    }


    mapRecords(QuerySnapshot<Map<String, dynamic>> spots){

      var spotList = spots.docs.map(
          (item)=> NewSpotModel(
            id:item['id'],
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

  locationFromText() async {
    var fullAddress = '${modelController.countryText.value.trim()} '
        '${modelController.cityText.value.trim()} '
        '${modelController.postalCodeText.value.trim()} '
        '${modelController.streetNameText.value.trim()} '
        '${modelController.streetNumberText.trim()}';

    List<Location> coordinates = await locationFromAddress(fullAddress);
    modelController.latitude.value = coordinates[0].latitude.toString();
    modelController.longitude.value = coordinates[0].longitude.toString();

  }

    buildMapOfMarkers() async{
      await fetchSpots();
      FindSpotController findSpotController = Get.find();
      findSpotController.markers.clear();
      for (var spot in findSpotController.spotList){
        findSpotController.markers.add(
            Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(double.parse(spot.spotAddress!.lat.toString()),double.parse(spot.spotAddress!.long.toString())),
                builder: (ctx) =>
                    Container(
                        child: GestureDetector(onTap:(){
                          Get.defaultDialog(title: spot.spotName.toString(), content: Text('Riders: ${spot.spotRiders}'));
                        },
                            child: Icon(Icons.place, size: 50,color: Colors.purple,)),)));

      }
    }
    
    spotCounterID()async{
      var myCounter = await FirebaseFirestore.instance.collection('spotCounter').doc('spotID').get();
      Map<String,dynamic>? counterValue = myCounter.data();
      findSpotController.spotCounterID.value = counterValue!['id'].toString();

      var collection = FirebaseFirestore.instance.collection('spotCounter');
      collection
          .doc('spotID')
          .update({'id' : counterValue['id']+1}) // <-- Updated data
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }

}