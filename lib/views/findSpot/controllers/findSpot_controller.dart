import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:skate_spot_finder/models/new_spot_model.dart';


class FindSpotController extends GetxController{


  var spotList = List<NewSpotModel>.empty().obs;
  var ridingStatus = Colors.red.obs;
  RxBool generalSwitch = true.obs;
  RxString dropDownItem = 'All'.obs;
  RxString dropDownText = 'united'.obs;
  RxString cityNameFinder = ''.obs;
  List<Marker> markers = [];
  RxString spotCounterID = '0'.obs;


}