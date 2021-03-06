import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skate_spot_finder/models/new_spot_model.dart';
import 'package:skate_spot_finder/services/firebase_services.dart';

class FindSpotController extends GetxController{


  var spotList = List<NewSpotModel>.empty().obs;
  var ridingStatus = Colors.red.obs;
  RxBool generalSwitch = true.obs;

}